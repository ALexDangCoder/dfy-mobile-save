import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'borrow_result_state.dart';

class BorrowResultCubit extends BaseCubit<BorrowResultState> {
  BorrowResultCubit() : super(BorrowResultInitial());

  BehaviorSubject<String> focusTextField = BehaviorSubject.seeded('');
  BehaviorSubject<String> interestRate = BehaviorSubject.seeded(INTEREST_1);
  BehaviorSubject<bool> clear = BehaviorSubject();

  BorrowRepository get _repo => Get.find();

  /// Filter interest
  static const String INTEREST_1 = '0-10%';
  static const String INTEREST_2 = '10-25%';
  static const String INTEREST_3 = '25-50%';
  static const String INTEREST_4 = '>50%';

  String paramInterest = INTEREST_1;
  List<bool> listInterest = [true, false, false, false];
  List<bool> listCachedInterest = [true, false, false, false];
  List<String> listInterestString = [
    INTEREST_1,
    INTEREST_2,
    INTEREST_3,
    INTEREST_4,
  ];

  int getIndexInterest(String nameInterest) {
    return listInterestString.indexWhere((element) => element == nameInterest);
  }

  void setInterest(String name) {
    paramInterest = name;
    listInterest = List.filled(4, false);
    listInterest[getIndexInterest(name)] = true;
    interestRate.add(name);
  }

  /// Filter loan to value

  static const String LOAN_VL1 = '0-10%';
  static const String LOAN_VL2 = '10-25%';
  static const String LOAN_VL3 = '25-50%';
  static const String LOAN_VL4 = '>50%';

  String paramLoan = LOAN_VL1;
  List<bool> listLoan = [true, false, false, false];
  List<bool> listCachedLoan = [true, false, false, false];
  List<String> listLoanString = [
    LOAN_VL1,
    LOAN_VL2,
    LOAN_VL3,
    LOAN_VL4,
  ];

  int getIndexLoanToValue(String nameLoan) {
    return listLoanString.indexWhere((element) => element == nameLoan);
  }

  void setLoanToValue(String name) {
    paramLoan = name;
    listLoan = List.filled(4, false);
    listLoan[getIndexLoanToValue(name)] = true;
    interestRate.add(name);
  }

  String message = '';
  List<PawnshopPackage> pawnshopPackage = [];
  List<PersonalLending> personalLending = [];

  /// Filter collateral


  void getTokenInf() {
    final List<TokenInf> listTokenSupport;
    final List<TokenInf> listTokenSupport2;

    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);

    listTokenSupport2 = TokenInf.decode(listToken);
    listCollateral.addAll(listTokenSupport);
    listLoanToken.addAll(listTokenSupport2);

  }

  List<TokenInf> listCollateral = [];
  List<String> listCachedCollateral = [];

  void selectCollateral(String key) {
    for (final item in listCollateral) {
      if (item.symbol == key) {
        if (item.isSelect == false) {
          item.isSelect = true;
        } else {
          item.isSelect = false;
        }
      }
    }
    interestRate.add('change');
  }
  void checkShowCollateral(){
    ///collateral
    if(listCachedCollateral.isEmpty){
      for(int i = 0; i<listCollateral.length;i++){
        listCollateral[i].isSelect = false;
      }
    } else {
      for(int i = 0; i<listCollateral.length;i++){
        for(int j = 0;j<listCachedCollateral.length;j++){
          if(listCollateral[i].symbol == listCachedCollateral[j]){
            listCollateral[i].isSelect = true;
          }
        }
      }
    }
    ///loanToken
    if(listCachedLoanToken.isEmpty){
      for(int i = 0; i<listLoanToken.length;i++){
        listLoanToken[i].isSelect = false;
      }
    } else {
      for(int i = 0; i<listLoanToken.length;i++){
        for(int j = 0;j<listCachedLoanToken.length;j++){
          if(listLoanToken[i].symbol == listCachedLoanToken[j]){
            listLoanToken[i].isSelect = true;
          }
        }
      }
    }
    /// loanType
    if(listCachedLoanType.isEmpty){
      for(int i = 0; i<listLoanType.length;i++){
        listLoanType[i].isSelect = false;
      }
    } else {
      for(int i = 0; i<listLoanType.length;i++){
        for(int j = 0;j<listCachedLoanType.length;j++){
          if(listLoanType[i].name == listCachedLoanType[j]){
            listLoanType[i].isSelect = true;
          }
        }
      }
    }
    ///duration
    if(listCachedDuration.isEmpty){
      for(int i = 0; i<listDuration.length;i++){
        listDuration[i].isSelect = false;
      }
    } else {
      for(int i = 0; i<listDuration.length;i++){
        for(int j = 0;j<listCachedDuration.length;j++){
          if(listDuration[i].duration == listCachedDuration[j]){
            listDuration[i].isSelect = true;
          }
        }
      }
    }
    ///network
    if(listCachedNetwork.isEmpty){
      for(int i = 0; i<network.length;i++){
        network[i].isSelect = false;
      }
    } else {
      for(int i = 0; i<network.length;i++){
        for(int j = 0;j<listCachedNetwork.length;j++){
          if(network[i].nameNetwork == listCachedNetwork[j]){
            network[i].isSelect = true;
          }
        }
      }
    }
  }

  /// Filter loanToken

  List<TokenInf> listLoanToken = [];
  List<String> listCachedLoanToken = [];

  void selectLoanToken(String key) {
    for (final item in listLoanToken) {
      if (item.symbol == key) {
        if (item.isSelect == false) {
          item.isSelect = true;
        } else {
          item.isSelect = false;
        }
      }
    }
    interestRate.add('change');
  }

  /// Filter LoanType

  List<FilterLoan> listLoanType = [
    FilterLoan(0, S.current.auto, false),
    FilterLoan(1, S.current.semi_auto, false)
  ];
  List<String> listCachedLoanType = [

  ];

  void selectLoanType(String key) {
    for (final item in listLoanType) {
      if (item.name == key) {
        if (item.isSelect == false) {
          item.isSelect = true;
        } else {
          item.isSelect = false;
        }
      }
    }
    interestRate.add('change');
  }

  /// Filter Duration

  List<FilterDuration> listDuration = [
    FilterDuration(0, S.current.week, false),
    FilterDuration(1, S.current.month, false)
  ];
  List<String> listCachedDuration = [

  ];

  void selectDuration(String key) {
    for (final item in listDuration) {
      if (item.duration == key) {
        if (item.isSelect == false) {
          item.isSelect = true;
        } else {
          item.isSelect = false;
        }
      }
    }
    interestRate.add('change');
  }

  /// Filter Network
  static const String ETHEREUM = 'Ethereum';
  static const String BINANCE = 'Binance SmartChain';
  static const String POLYGON = 'Polygon';
  static const String AVALANNCHE = 'Avalanche';
  static const String FANTOM = 'Fantom';
  static const String SOLANA = 'Solana';

  List<FilterNetwork> network = [
    FilterNetwork(0,ETHEREUM, false),
    FilterNetwork(1,BINANCE, false),
    FilterNetwork(2,POLYGON, false),
    FilterNetwork(3,AVALANNCHE, false),
    FilterNetwork(4,FANTOM, false),
    FilterNetwork(5,SOLANA, false),
  ];

  List<String> listCachedNetwork = [

  ];


  void selectNetwork(String key) {
    for (final item in network) {
      if (item.nameNetwork == key) {
        if (item.isSelect == false) {
          item.isSelect = true;
        } else {
          item.isSelect = false;
        }
      }
    }
    interestRate.add('change');
  }


  /// apply

  String interestRateParam() {
    switch (paramInterest) {
      case INTEREST_1:
        return '0:0.25';
      case INTEREST_2:
        return '0.1:0.25';
      case INTEREST_3:
        return '0.25:5';
      default:
        return '0.5:1';
    }
  }

  String loanToValueParam() {
    switch (paramLoan) {
      case LOAN_VL1:
        return '0:0.25';
      case LOAN_VL2:
        return '0.1:0.25';
      case LOAN_VL3:
        return '0.25:5';
      default:
        return '0.5:1';
    }
  }
  List<String> paramCollateral = [];

  void getParamCollateral() {
    for (final element in listCollateral) {
      if (element.isSelect == true) {
        listCachedCollateral.add(element.symbol ?? '');
        paramCollateral.add(element.symbol ?? '');
      }
    }
  }

  List<String> paramLoanToken = [];

  void getParamLoanToken() {
    for (final element in listLoanToken) {
      if (element.isSelect == true) {
        listCachedLoanToken.add(element.symbol ?? '');
        paramLoanToken.add(element.symbol ?? '');
      }
    }
  }

  List<String> paramNetwork = [];

  void getParamNetwork() {
    for (final element in network) {
      if (element.isSelect == true) {
        listCachedNetwork.add(element.nameNetwork ?? '');
        paramNetwork.add(element.nameNetwork ?? '');
      }
    }
  }
  List<String> paramLoanType = [];

  void getParamLoanType() {
    for (final element in listLoanType) {
      if (element.name == S.current.auto && element.isSelect == true) {
        listCachedLoanType.add(element.name ?? '');
        paramLoanType.add('0');
      }
      if (element.name == S.current.semi_auto && element.isSelect == true) {
        paramLoanType.add('1');
        listCachedLoanType.add(element.name ?? '');
      }
    }
  }

  List<String> paramDuration = [];

  void getParamDuration() {
    for (final element in listDuration) {
      if (element.duration == S.current.week && element.isSelect == true) {
        paramDuration.add('0');
        listCachedDuration.add(element.duration ?? '');
      }
      if (element.duration == S.current.month && element.isSelect == true) {
        paramDuration.add('1');
        listCachedDuration.add(element.duration ?? '');
      }
    }
  }

  String getParam(List<dynamic> list) {
    final query = StringBuffer();
    for (final value in list) {
      query.write('$value,');
    }
    return query.toString();
  }

  void resetFilter() {

    listInterest = [true, false, false, false];
    listLoan = [true, false, false, false];
    for(int i = 0; i<network.length;i++){
      network[i].isSelect = false;
    }
    for(int i = 0; i<listLoanType.length;i++){
      listLoanType[i].isSelect = false;
    }
    for(int i = 0; i<listDuration.length;i++){
      listDuration[i].isSelect = false;
    }
    for(int i = 0; i<listCollateral.length;i++){
      listCollateral[i].isSelect = false;
    }
    for(int i = 0; i<listLoanToken.length;i++){
      listLoanToken[i].isSelect = false;
    }

    interestRate.add('change');
  }

  void applyFilter(String name) {

    listCachedCollateral.clear();
    listCachedLoanToken.clear();
    listCachedLoanType.clear();
    listCachedDuration.clear();
    listCachedNetwork.clear();

    listCachedInterest = listInterest;
    listCachedLoan = listLoan;
    getParamDuration();
    getParamLoanType();
    getParamCollateral();
    getParamNetwork();
    getParamLoanToken();

    callApi(
      name: name,
      interestRanges: interestRateParam(),
      loanToValueRanges: loanToValueParam(),
      collateralSymbols: getParam(paramCollateral),
      loanSymbols: getParam(paramLoanToken),
      loanType: getParam(paramLoanType),
      duration: getParam(paramDuration),
    );
  }

  ///
  void callApi({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? duration,
  }) {
    showLoading();
    getPawnshopPackageResult(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      duration: duration,
      loanType: loanType,
    );
    getPersonLendingResult(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      duration: duration,
      loanType: loanType,
    );
  }

  int page = 0;

  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;

  Future<void> refreshPosts() async {
    canLoadMoreList = true;
    if (!refresh) {
      showLoading();
      emit(BorrowResultLoading());
      page = 0;
      refresh = true;
      callApi();
    }
  }

  Future<void> loadMorePosts() async {
    if (!loadMore) {
      emit(BorrowResultLoadmore());
      page += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getPawnshopPackageResult();
    }
  }

  Future<void> getPersonLendingResult({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? duration,
  }) async {
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
      duration: duration,
    );
    result.when(
      success: (res) {
        emit(BorrowPersonSuccess(CompleteType.SUCCESS, personalLending: res));
      },
      error: (error) {
        emit(BorrowPersonSuccess(CompleteType.ERROR, message: error.message));
      },
    );
  }

  Future<void> getPawnshopPackageResult({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? duration,
  }) async {
    final Result<List<PawnshopPackage>> result = await _repo.getListPawnshop(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      loanType: loanType,
      duration: duration,
      page: page.toString(),
    );
    result.when(
      success: (res) {
        emit(
          BorrowPawnshopSuccess(
            CompleteType.SUCCESS,
            pawnshopPackage: res,
          ),
        );
      },
      error: (error) {
        emit(BorrowPawnshopSuccess(CompleteType.ERROR, message: error.message));
      },
    );
  }
}

class FilterLoan {
  int? id;
  String? name;
  bool? isSelect;

  FilterLoan(this.id, this.name, this.isSelect);
}

class FilterDuration {
  int? id;
  String? duration;
  bool? isSelect;

  FilterDuration(this.id, this.duration, this.isSelect);
}

class FilterNetwork {
  int? id;
  String? nameNetwork;
  bool? isSelect;

  FilterNetwork(this.id,this.nameNetwork, this.isSelect);
}
