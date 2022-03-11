import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/dialog_filter.dart';
import 'package:Dfy/presentation/pawn/personal_lending/bloc/personal_lending_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PersonalLendingBloc extends BaseCubit<PersonalLendingState> {
  PersonalLendingBloc() : super(PersonalLendingInitial()) {
    getTokenInf();
  }

  BorrowRepository get _repo => Get.find();
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');

  //load more
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  static const int ZERO_TO_TEN = 0;
  static const int TEN_TO_TWENTY_FIVE = 1;
  static const int TWENTY_FIVE_TO_FIVETY = 2;
  static const int MORE_THAN_FIVETY = 3;
  static const String A_TO_Z_REPUTATION = 'reputation,desc';
  static const String Z_TO_A_REPUTATION = 'reputation,asc';
  static const String A_TO_Z_INTEREST = 'interest,desc';
  static const String Z_TO_A_INTEREST = 'interest,asc';
  static const String A_TO_Z_COMPLETED = 'completedContracts,desc';
  static const String Z_TO_A_COMPLETED = 'completedContracts,asc';
  String? interestRanges;
  String? name;
  String? loanToValueRanges;
  String? collateralSymbols;
  String? cusSort;

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;
  String mess = '';
  List<PersonalLending> list = [];

  //filter
  TypeFilter? typeRating = TypeFilter.HIGH_TO_LOW;
  TypeFilter? typeInterest = TypeFilter.LOW_TO_HIGH;
  TypeFilter? typeSigned = TypeFilter.HIGH_TO_LOW;
  BehaviorSubject<List<bool>> listFilterStream = BehaviorSubject.seeded([
    false,
    false,
    false,
    false,
  ]);
  List<bool> listFilter = [
    false,
    false,
    false,
    false,
  ];

  //status filter
  String? checkStatus;
  String? searchStatus;
  List<bool>? statusFilterNumberRange;
  List<int> statusListCollateral = [];
  List<TokenModelPawn> listCollateralTokenFilter = [];
  List<TokenInf> listTokenSupport = [];

  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
    for (final TokenInf value in listTokenSupport) {
      listCollateralTokenFilter.add(
        TokenModelPawn(
          symbol: value.symbol,
          address: value.address,
          id: value.id.toString(),
        ),
      );
    }
  }

  void funReset() {
    textSearch.sink.add('');
    listFilter = List.filled(4, false);
    listFilterStream.add(listFilter);
    for (final TokenModelPawn value in listCollateralTokenFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
  }

  void chooseFilter({required int index}) {
    listFilter = List.filled(4, false);
    listFilter[index] = true;
    listFilterStream.sink.add(listFilter);
  }

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getPersonLendingResult();
    }
  }

  void getTextFilter(TypeFilter type, String checkType) {
    page = 0;
    if (checkType == S.current.rating) {
      if (type == TypeFilter.HIGH_TO_LOW) {
        cusSort = A_TO_Z_REPUTATION;
      } else {
        cusSort = Z_TO_A_REPUTATION;
      }
    } else if (checkType == S.current.interest_rate_pawn) {
      if (type == TypeFilter.HIGH_TO_LOW) {
        cusSort = A_TO_Z_INTEREST;
      } else {
        cusSort = Z_TO_A_INTEREST;
      }
    } else if (checkType == S.current.signed_contracts) {
      if (type == TypeFilter.HIGH_TO_LOW) {
        cusSort = A_TO_Z_COMPLETED;
      } else {
        cusSort = Z_TO_A_COMPLETED;
      }
    } else {
      cusSort = '';
    }
  }

  void statusFilterFirst() {
    if (checkStatus == null) {
      checkStatus = 'have';
      searchStatus = '';
      statusFilterNumberRange = [false, false, false, false];
    } else {
      textSearch.sink.add(searchStatus ?? '');
      listFilter = statusFilterNumberRange ?? [];
      listFilterStream.add(listFilter);
      for (int i = 0; i < listCollateralTokenFilter.length; i++) {
        if (checkStatusFirstFilter(i, statusListCollateral)) {
          listCollateralTokenFilter[i].isCheck = true;
        } else {
          listCollateralTokenFilter[i].isCheck = false;
        }
      }
    }
  }

  bool checkStatusFirstFilter(int i, List<int> list) {
    for (final int value in list) {
      if (i == value) {
        return true;
      }
    }
    return false;
  }

  void funFilter() {
    page = 0;
    searchStatus = textSearch.value;
    statusFilterNumberRange = listFilterStream.value;
    statusListCollateral = [];
    interestRanges = '';
    name = '';
    collateralSymbols = '';
    for (int i = 0; i < listCollateralTokenFilter.length; i++) {
      if (listCollateralTokenFilter[i].isCheck) {
        statusListCollateral.add(i);
        if (collateralSymbols?.isNotEmpty ?? false) {
          collateralSymbols =
              '$collateralSymbols,${listCollateralTokenFilter[i].symbol ?? ''}';
        } else {
          collateralSymbols = listCollateralTokenFilter[i].symbol;
        }
      }
    }
    for (int i = 0; i < listFilterStream.value.length; i++) {
      if (listFilterStream.value[i]) {
        interestRanges = checkInterest(i);
      }
    }
    name = textSearch.value;
    getPersonLendingResult();
  }

  String checkInterest(int index) {
    switch (index) {
      case ZERO_TO_TEN:
        return '0:0.1';
      case TEN_TO_TWENTY_FIVE:
        return '0.1:0.25';
      case TWENTY_FIVE_TO_FIVETY:
        return '0.25:0.5';
      case MORE_THAN_FIVETY:
        return '0.5:1';
      default:
        return '';
    }
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getPersonLendingResult();
    }
  }

//
  Future<void> getPersonLendingResult() async {
    showLoading();
    emit(PersonalLendingLoading());
    final Result<List<PersonalLending>> result =
        await _repo.getListPersonalLendingHard(
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      page: page.toString(),
      cusSort: cusSort,
      isNft: false,
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        _isLoading = false;
        emit(
          PersonalLendingSuccess(
            CompleteType.SUCCESS,
            listPersonal: res,
          ),
        );
      },
      error: (error) {
        emit(
          PersonalLendingSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }
}
