import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/presentation/pawn/collateral_result/bloc/collateral_result_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollateralResultBloc extends BaseCubit<CollateralResultState> {
  CollateralResultBloc() : super(CollateralResultInitial());

  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isWeek = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isMonth = BehaviorSubject.seeded(false);

  //status filter
  String? checkStatus;
  String? searchStatus;
  List<int> statusListCollateral = [];
  List<int> statusListLoan = [];
  List<int> statusListNetwork = [];
  bool statusWeek = false;
  bool statusMonth = false;

  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;

  //
  String mess = '';

  BorrowRepository get _pawnService => Get.find();

  List<TokenModelPawn> listLoanTokenFilter = [
    //1
    TokenModelPawn(id: '1', address: '', symbol: 'DFY'),
    TokenModelPawn(id: '1', address: '', symbol: 'USDT'),
    TokenModelPawn(id: '1', address: '', symbol: 'BNB'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
  ];

  List<CollateralResultModel> listCollateralResultModel = [];

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

  List<TokenModelPawn> listNetworkFilter = [
    TokenModelPawn(symbol: 'Ethereum dsafsdafsdfsadfsadf'),
    TokenModelPawn(symbol: 'Ethereum dsafsdafsdfsadfsadf'),
    TokenModelPawn(symbol: 'Ethereum dsafsdafsdfsadfsadf'),
    TokenModelPawn(symbol: 'Binance Smart doanh'),
    TokenModelPawn(symbol: 'Alavanche'),
    TokenModelPawn(symbol: 'Polygon'),
    TokenModelPawn(symbol: 'Alavanche'),
    TokenModelPawn(symbol: 'Polygon'),
    TokenModelPawn(symbol: 'Polygon'),
    TokenModelPawn(symbol: 'Alavanche'),
    TokenModelPawn(symbol: 'Polygon'),
  ];

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getListCollateral();
    }
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getListCollateral();
    }
  }

  Future<void> getListCollateral() async {
    showLoading();
    emit(CollateralResultLoading());
    final Result<List<CollateralResultModel>> response =
        await _pawnService.getListCollateral(
      page: page.toString(),
      size: '12',
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        _isLoading = false;
        emit(
          CollateralResultSuccess(
            CompleteType.SUCCESS,
            listCollateral: response,
          ),
        );
      },
      error: (error) {
        emit(
          CollateralResultSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }

  void statusFilterFirst() {
    if (checkStatus == null) {
      checkStatus = 'have';
      searchStatus = '';
    } else {
      textSearch.sink.add(searchStatus ?? '');
      for (int i = 0; i < listCollateralTokenFilter.length; i++) {
        if (checkStatusFirstFilter(i, statusListCollateral)) {
          listCollateralTokenFilter[i].isCheck = true;
        } else {
          listCollateralTokenFilter[i].isCheck = false;
        }
      }
      for (int i = 0; i < listLoanTokenFilter.length; i++) {
        if (checkStatusFirstFilter(i, statusListLoan)) {
          listLoanTokenFilter[i].isCheck = true;
        } else {
          listLoanTokenFilter[i].isCheck = false;
        }
      }
      for (int i = 0; i < listNetworkFilter.length; i++) {
        if (checkStatusFirstFilter(i, statusListNetwork)) {
          listNetworkFilter[i].isCheck = true;
        } else {
          listNetworkFilter[i].isCheck = false;
        }
      }
      isWeek.add(statusWeek);
      isMonth.add(statusMonth);
    }
  }

  void funFilter() {
    page = 0;
    searchStatus = textSearch.value;
    statusListCollateral = [];
    for (int i = 0; i < listCollateralTokenFilter.length; i++) {
      if (listCollateralTokenFilter[i].isCheck) {
        statusListCollateral.add(i);
      }
    }
    statusListNetwork = [];
    for (int i = 0; i < listNetworkFilter.length; i++) {
      if (listNetworkFilter[i].isCheck) {
        statusListNetwork.add(i);
      }
    }
    statusListLoan = [];
    for (int i = 0; i < listLoanTokenFilter.length; i++) {
      if (listLoanTokenFilter[i].isCheck) {
        statusListLoan.add(i);
      }
    }
    statusMonth = isMonth.value;
    statusWeek = isWeek.value;
    //todo filter
  }

  bool checkStatusFirstFilter(int i, List<int> list) {
    for (final int value in list) {
      if (i == value) {
        return true;
      }
    }
    return false;
  }

  void funReset() {
    textSearch.sink.add('');
    for (final TokenModelPawn value in listCollateralTokenFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
    for (final TokenModelPawn value in listLoanTokenFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
    isMonth.add(false);
    isWeek.add(false);
    for (final TokenModelPawn value in listNetworkFilter) {
      if (value.isCheck) {
        value.isCheck = false;
      }
    }
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
  }
}
