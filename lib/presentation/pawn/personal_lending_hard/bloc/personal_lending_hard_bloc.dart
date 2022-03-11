import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/dialog_filter.dart';
import 'package:Dfy/presentation/pawn/personal_lending_hard/bloc/personal_lending_hard_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PersonalLendingHardBloc extends BaseCubit<PersonalLendingHardState> {
  PersonalLendingHardBloc() : super(PersonalLendingHardInitial());

  BorrowRepository get _repo => Get.find();
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isHardNFT = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isSoftNFT = BehaviorSubject.seeded(false);

  //load more
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  static const int ZERO_TO_TEN = 0;
  static const int TEN_TO_TWENTY_FIVE = 1;
  static const int TWENTY_FIVE_TO_FIVETY = 2;
  static const int ALL = 0;
  static const int SORT = 1;
  static const int HARD = 2;
  static const int MORE_THAN_FIVETY = 3;
  static const String A_TO_Z_REPUTATION = 'reputation,desc';
  static const String Z_TO_A_REPUTATION = 'reputation,asc';
  static const String A_TO_Z_INTEREST = 'interest,desc';
  static const String Z_TO_A_INTEREST = 'interest,asc';
  static const String A_TO_Z_COMPLETED = 'completedContracts,desc';
  static const String Z_TO_A_COMPLETED = 'completedContracts,asc';

  String? interestRanges;
  String? name;
  String? cusSort;
  int typePersonal = 0;

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
  //status filter
  String? checkStatus;
  String? searchStatus;
  bool? statusHardFilter;
  bool? statusSoftFilter;
  List<bool>? statusFilterNumberRange;
  List<bool>? statusFilterNumberLoan;

  void funReset() {
    textSearch.sink.add('');
    listFilter = List.filled(4, false);
    listFilterStream.add(listFilter);
    isSoftNFT.add(false);
    isHardNFT.add(false);
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

  void statusFilterFirst() {
    if (checkStatus == null) {
      checkStatus = 'have';
      searchStatus = '';
      statusFilterNumberRange = [false, false, false, false];
      statusFilterNumberLoan = [false, false, false, false];
      statusHardFilter = false;
      statusSoftFilter = false;
    } else {
      textSearch.sink.add(searchStatus ?? '');

      listFilter = statusFilterNumberRange ?? [];
      listFilterStream.add(listFilter);
      isHardNFT.add(statusHardFilter ?? false);
      isSoftNFT.add(statusSoftFilter ?? false);
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
    statusHardFilter = isSoftNFT.value;
    statusSoftFilter = isHardNFT.value;
    name = '';
    interestRanges = '';
    typePersonal = checkType();
    name = textSearch.value;
    for (int i = 0; i < listFilterStream.value.length; i++) {
      if (listFilterStream.value[i]) {
        interestRanges = checkInterest(i);
      }
    }
    getPersonLendingResult();
  }

  int checkType() {
    if (isSoftNFT.value && !isHardNFT.value) {
      return SORT;
    } else if (!isSoftNFT.value && isHardNFT.value) {
      return HARD;
    } else {
      return ALL;
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
    emit(PersonalLendingHardLoading());
    final Result<List<PersonalLending>> result =
        await _repo.getListPersonalLendingHard(
      name: name,
      interestRanges: interestRanges,
      page: page.toString(),
      cusSort: cusSort,
      collateralType: typePersonal.toString(),
      isNft: true,
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        emit(
          PersonalLendingHardSuccess(
            CompleteType.SUCCESS,
            listPersonal: res,
          ),
        );
        _isLoading = false;
      },
      error: (error) {
        emit(
          PersonalLendingHardSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }
}
