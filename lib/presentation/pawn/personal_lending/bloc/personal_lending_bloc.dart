import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/presentation/pawn/pawn_list/ui/dialog_filter.dart';
import 'package:Dfy/presentation/pawn/personal_lending/bloc/personal_lending_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PersonalLendingBloc extends BaseCubit<PersonalLendingState> {
  PersonalLendingBloc() : super(PersonalLendingInitial());

  BorrowRepository get _repo => Get.find();
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');

  //load more
  final bool _canLoadMore = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  static const int ZERO_TO_TEN = 0;
  static const int TEN_TO_TWENTY_FIVE = 1;
  static const int TWENTY_FIVE_TO_FIVETY = 2;
  static const int MORE_THAN_FIVETY = 3;
  String? interestRanges;
  String? name;
  String? loanToValueRanges;
  String? collateralSymbols;

  bool get canLoadMore => _canLoadMore;

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
  BehaviorSubject<List<bool>> listFilterLoanStream = BehaviorSubject.seeded([
    false,
    false,
    false,
    false,
  ]);
  List<bool> listFilterLoan = [
    false,
    false,
    false,
    false,
  ];

  //status filter
  //status filter
  String? checkStatus;
  String? searchStatus;
  List<bool>? statusFilterNumberRange;
  List<bool>? statusFilterNumberLoan;
  List<int> statusListCollateral = [];
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

  void funReset() {
    textSearch.sink.add('');
    listFilter = List.filled(4, false);
    listFilterStream.add(listFilter);
    listFilterLoan = List.filled(4, false);
    listFilterLoanStream.add(listFilterLoan);
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

  void chooseFilterLoan({required int index}) {
    listFilterLoan = List.filled(4, false);
    listFilterLoan[index] = true;
    listFilterLoanStream.sink.add(listFilterLoan);
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
    } else {
      textSearch.sink.add(searchStatus ?? '');

      listFilter = statusFilterNumberRange ?? [];
      listFilterStream.add(listFilter);
      listFilterLoan = statusFilterNumberLoan ?? [];
      listFilterLoanStream.add(listFilterLoan);
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
    page = 1;
    searchStatus = textSearch.value;
    statusFilterNumberRange = listFilterStream.value;
    statusFilterNumberLoan = listFilterLoanStream.value;
    statusListCollateral = [];
    for (int i = 0; i < listCollateralTokenFilter.length; i++) {
      if (listCollateralTokenFilter[i].isCheck) {
        statusListCollateral.add(i);
      }
    }
    String? interestRanges;
    name = textSearch.value;
    String? loanToValueRanges;
    String? collateralSymbols;
    getPersonLendingResult(
      name: name,
    );
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
  Future<void> getPersonLendingResult({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
  }) async {
    emit(PersonalLendingLoading());
    final Result<List<PersonalLending>> result =
        await _repo.getListPersonalLending(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      loanType: loanType,
      page: page.toString(),
    );
    result.when(
      success: (res) {
        if (res.isNotEmpty) {
          canLoadMore = true;
          emit(
            PersonalLendingSuccess(
              CompleteType.SUCCESS,
              listPersonal: res,
            ),
          );
          _isLoading = false;
        } else {
          canLoadMore = false;
        }
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
