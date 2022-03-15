import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_result/bloc/collateral_result_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollateralResultBloc extends BaseCubit<CollateralResultState> {
  CollateralResultBloc() : super(CollateralResultInitial()) {
    getTokenInf();
  }

  BehaviorSubject<bool> isWeek = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isMonth = BehaviorSubject.seeded(false);
  static const int WEEK = 0;
  static const int MONTH = 1;

  //status filter
  String? checkStatus;
  List<int> statusListCollateral = [];
  List<int> statusListLoan = [];
  List<int> statusListNetwork = [];
  bool statusWeek = false;
  bool statusMonth = false;
  String? collateralSymbols;
  String? durationTypes;
  String? loanSymbols;
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;

  //
  String mess = '';

  BorrowRepository get _pawnService => Get.find();

  List<TokenModelPawn> listLoanTokenFilter = [];

  List<CollateralResultModel> listCollateralResultModel = [];

  List<TokenModelPawn> listCollateralTokenFilter = [];

  List<TokenModelPawn> listNetworkFilter = [
    TokenModelPawn(symbol: 'Ethereum dsafsdafsdfsadfsadf'),
    TokenModelPawn(symbol: 'Ethereum dsafsdafsdfsadfsadf'),
    TokenModelPawn(symbol: 'Ethereum dsafsdafsdfsadfsadf'),
    TokenModelPawn(symbol: 'Binance Smart doanh'),
    TokenModelPawn(symbol: 'Alavanche'),
    TokenModelPawn(symbol: 'Polygon'),
    TokenModelPawn(symbol: 'Alavanche'), //todo
    TokenModelPawn(symbol: 'Polygon'),
    TokenModelPawn(symbol: 'Polygon'),
    TokenModelPawn(symbol: 'Alavanche'),
    TokenModelPawn(symbol: 'Polygon'),
  ];
  BehaviorSubject<List<ReputationBorrower>> listReputationBorrower =
      BehaviorSubject.seeded([]);
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
          url: value.iconUrl,
        ),
      );
      listLoanTokenFilter.add(
        TokenModelPawn(
          symbol: value.symbol,
          address: value.address,
          id: value.id.toString(),
          url: value.iconUrl,
        ),
      );
    }
  }

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getListCollateral();
    }
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getListCollateral();
    }
  }

  Future<void> getReputation(String addressWallet) async {
    final Result<List<ReputationBorrower>> response =
        await _pawnService.getListReputation(
      addressWallet: addressWallet,
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          listReputationBorrower.add(response);
        }
      },
      error: (error) {},
    );
  }

  String getTime({
    required int type,
    required int time,
  }) {
    if (type == WEEK) {
      return '$time ${S.current.week}';
    }
    return '$time ${S.current.month}';
  }

  Future<void> getListCollateral() async {
    showLoading();
    emit(CollateralResultLoading());
    final Result<List<CollateralResultModel>> response =
        await _pawnService.getListCollateral(
      collateralSymbols: collateralSymbols,
      durationTypes: durationTypes,
      loanSymbols: loanSymbols,
      page: page.toString(),
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          canLoadMoreMy = true;
          String addressWallet = '';
          for (final CollateralResultModel value in response) {
            if (value.walletAddress?.isNotEmpty ?? false) {
              if (addressWallet.isNotEmpty) {
                addressWallet = '$addressWallet,${value.walletAddress}';
              } else {
                addressWallet = value.walletAddress.toString();
              }
            }
          }
          getReputation(addressWallet);
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
    } else {
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
    statusListCollateral = [];
    statusListNetwork = [];
    for (int i = 0; i < listNetworkFilter.length; i++) {
      if (listNetworkFilter[i].isCheck) {
        statusListNetwork.add(i);
      }
    }
    statusListLoan = [];
    statusMonth = isMonth.value;
    statusWeek = isWeek.value;
    if (isMonth.value && isWeek.value) {
      durationTypes = '$WEEK,$MONTH';
    } else if (!isMonth.value && isWeek.value) {
      durationTypes = '$WEEK';
    } else {
      durationTypes = '$MONTH';
    }
    //
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
    //
    loanSymbols = '';
    for (int i = 0; i < listLoanTokenFilter.length; i++) {
      if (listLoanTokenFilter[i].isCheck) {
        statusListLoan.add(i);
        if (loanSymbols?.isNotEmpty ?? false) {
          loanSymbols = '$loanSymbols,${listLoanTokenFilter[i].symbol ?? ''}';
        } else {
          loanSymbols = listLoanTokenFilter[i].symbol;
        }
      }
    }
    getListCollateral();
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
}
