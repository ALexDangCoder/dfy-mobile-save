import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/pawn_list/bloc/pawn_list_state.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/dialog_filter.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PawnListBloc extends BaseCubit<PawnListState> {
  PawnListBloc() : super(PawnListInitial());

  //load more
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  static const String A_TO_Z_REPUTATION = 'reputation,desc';
  static const String Z_TO_A_REPUTATION = 'reputation,asc';
  static const String A_TO_Z_INTEREST = 'interest,desc';
  static const String Z_TO_A_INTEREST = 'interest,asc';
  static const String A_TO_Z_COMPLETED = 'completedContracts,desc';
  static const String Z_TO_A_COMPLETED = 'completedContracts,asc';

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;

  //
  String mess = '';
  TypeFilter? typeRating = TypeFilter.HIGH_TO_LOW;
  TypeFilter? typeInterest = TypeFilter.LOW_TO_HIGH;
  TypeFilter? typeSigned = TypeFilter.HIGH_TO_LOW;
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  List<PawnShopModelMy> list = [];
  List<bool> listFilter = [
    false,
    false,
    false,
    false,
  ];
  BehaviorSubject<List<bool>> listFilterStream = BehaviorSubject.seeded([
    false,
    false,
    false,
    false,
  ]);

  List<TokenModelPawn> listLoanTokenFilter = [
    //1
    TokenModelPawn(id: '1', address: '', symbol: 'DFY'),
    TokenModelPawn(id: '1', address: '', symbol: 'USDT'),
    TokenModelPawn(id: '1', address: '', symbol: 'BNB'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
  ];

  List<TokenModelPawn> listCollateralTokenFilter = [
    //2
    TokenModelPawn(id: '1', address: '', symbol: 'DFY'),
    TokenModelPawn(id: '1', address: '', symbol: 'USDT'),
    TokenModelPawn(id: '1', address: '', symbol: 'BNB'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
  ];

  BorrowRepository get _pawnService => Get.find();
  static const int ZERO_TO_TEN = 0;
  static const int TEN_TO_TWENTY_FIVE = 1;
  static const int TWENTY_FIVE_TO_FIVETY = 2;
  static const int MORE_THAN_FIVETY = 3;

  //status filter
  String? checkStatus;
  String? searchStatus;
  String? cusSort;
  List<bool>? statusFilterNumber;
  List<int> statusListLoan = [];
  List<int> statusListCollateral = [];

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getListPawn();
    }
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getListPawn();
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
      statusFilterNumber = [false, false, false, false];
    } else {
      textSearch.sink.add(searchStatus ?? '');
      listFilter = statusFilterNumber ?? [];
      listFilterStream.add(listFilter);
      for (int i = 0; i < listLoanTokenFilter.length; i++) {
        if (checkStatusFirstFilter(i, statusListLoan)) {
          listLoanTokenFilter[i].isCheck = true;
        } else {
          listLoanTokenFilter[i].isCheck = false;
        }
      }
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

  void funOnSearch(String value) {
    textSearch.sink.add(value);
  }

  void funReset() {
    textSearch.sink.add('');
    listFilter = List.filled(4, false);
    listFilterStream.add(listFilter);
    for (final TokenModelPawn value in listLoanTokenFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
    for (final TokenModelPawn value in listCollateralTokenFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
  }

  String checkStatusFilter() {
    for (int i = 0; i < listFilterStream.value.length; i++) {
      if (listFilterStream.value[i]) {
        if (i == ZERO_TO_TEN) {
          return S.current.zero_to_ten;
        } else if (i == TEN_TO_TWENTY_FIVE) {
          return S.current.ten_twenty;
        } else if (i == TWENTY_FIVE_TO_FIVETY) {
          return S.current.twenty_five;
        } else {
          return S.current.more_than_fifty;
        }
      }
    }
    return '';
  }

  void funFilter() {
    page = 1;
    searchStatus = textSearch.value;
    statusFilterNumber = listFilterStream.value;
    statusListCollateral = [];
    statusListLoan = [];
    for (int i = 0; i < listLoanTokenFilter.length; i++) {
      if (listLoanTokenFilter[i].isCheck) {
        statusListLoan.add(i);
      }
    }
    for (int i = 0; i < listCollateralTokenFilter.length; i++) {
      if (listCollateralTokenFilter[i].isCheck) {
        statusListCollateral.add(i);
      }
    }
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
  }

  Future<void> getListPawn() async {
    showLoading();
    emit(PawnListLoading());
    final Result<List<PawnShopModelMy>> response =
        await _pawnService.getListPawnShopMy();
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        emit(
          PawnListSuccess(
            CompleteType.SUCCESS,
            listPawn: response,
          ),
        );
        _isLoading = false;
      },
      error: (error) {
        emit(
          PawnListSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }

  void chooseFilter({required int index}) {
    listFilter = List.filled(4, false);
    listFilter[index] = true;
    listFilterStream.sink.add(listFilter);
  }
}
