import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:rxdart/rxdart.dart';

class CollateralResultBloc {
  BehaviorSubject<int> numberListLength = BehaviorSubject.seeded(0);
  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isWeek = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isMonth = BehaviorSubject.seeded(false);

  //filter

  //status filter
  String? checkStatus;
  String? searchStatus;
  List<int> statusListCollateral = [];
  List<int> statusListLoan = [];
  List<int> statusListNetwork = [];
  bool statusWeek = false;
  bool statusMonth = false;
  int page = 1;

  List<TokenModelPawn> listLoanTokenFilter = [
    //1
    TokenModelPawn(id: '1', address: '', symbol: 'DFY'),
    TokenModelPawn(id: '1', address: '', symbol: 'USDT'),
    TokenModelPawn(id: '1', address: '', symbol: 'BNB'),
    TokenModelPawn(id: '1', address: '', symbol: 'BTC'),
  ];

  List<CollateralResultModel> listCollateralResultModel = [
    CollateralResultModel(
      loadToken: 'DFY',
      duration: '12 months',
      address: '12341234123434',
      rate: '1000',
      iconLoadToken: ImageAssets.ic_dfy,
      iconBorrower: ImageAssets.ic_dfy,
      contracts: '100',
      iconCollateral: ImageAssets.ic_dfy,
      collateral: '10 ETH',
    ),
    CollateralResultModel(
      loadToken: 'DFY',
      duration: '12 months',
      address: '12341234123434',
      rate: '1000',
      iconLoadToken: ImageAssets.ic_dfy,
      iconBorrower: ImageAssets.ic_dfy,
      contracts: '100',
      iconCollateral: ImageAssets.ic_dfy,
      collateral: '10 ETH',
    ),
    CollateralResultModel(
      loadToken: 'DFY',
      duration: '12 months',
      address: '12341234123434',
      rate: '1000',
      iconLoadToken: ImageAssets.ic_dfy,
      iconBorrower: ImageAssets.ic_dfy,
      contracts: '100',
      iconCollateral: ImageAssets.ic_dfy,
      collateral: '10 ETH',
    ),
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

  void funOnSearch(String value) {
    textSearch.sink.add(value);
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
    page = 1;
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
