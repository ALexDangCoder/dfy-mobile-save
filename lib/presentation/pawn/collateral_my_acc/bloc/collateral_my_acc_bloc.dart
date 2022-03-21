import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/domain/repository/market_place/wallet_address_respository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_my_acc/bloc/collateral_my_acc_state.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollateralMyAccBloc extends BaseCubit<CollateralMyAccState> {
  CollateralMyAccBloc() : super(CollateralMyAccInitial()) {
    getListWallet();
  }

  String mess = '';
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  List<CollateralResultModel> list = [];

  bool get canLoadMore => canLoadMoreMy;

  BorrowRepository get _pawnService => Get.find();

  bool get isRefresh => _isRefresh;
  static const int PROCESSING_CREATE = 1;
  static const int FAIL_CREATE = 2;
  static const int OPEN = 3;
  static const int PROCESSING_ACCEPT = 4;
  static const int PROCESSING_WITHDRAW = 5;
  static const int ACCEPTED = 6;
  static const int WITHDRAW = 7;
  static const int FAILED = 8;
  bool checkWalletAddress = false;
  BehaviorSubject<bool> isChooseAcc = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textAddressFilter =
      BehaviorSubject.seeded(S.current.all);
  BehaviorSubject<bool> isAll = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isOpen = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAccepted = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isWithDrawn = BehaviorSubject.seeded(false);

  WalletAddressRepository get _walletAddressRepository => Get.find();

  List<String> listAcc = [
    S.current.all,
  ];
  List<TokenInf> listTokenSupport = [];
  List<TokenModelPawn> listCollateralTokenFilter = [];
  List<TokenModelPawn> listLoanTokenFilter = [];

  //status
  String? checkStatus;
  String? statusWallet;
  List<int> statusListCollateral = [];
  List<int> statusListLoan = [];
  bool statusAll = false;
  bool statusOpen = false;
  bool statusAccepted = false;
  bool statusWithDrawn = false;

  //filter
  String loanToken = '';
  String collateralToken = '';
  String status = '';

  void chooseAddressFilter(String address) {
    textAddressFilter.sink.add(
      address,
    );
    isChooseAcc.sink.add(false);
  }

  void funFilter() {
    page = 0;
    statusListCollateral = [];
    statusListLoan = [];
    loanToken = '';
    for (int i = 0; i < listLoanTokenFilter.length; i++) {
      if (listLoanTokenFilter[i].isCheck) {
        statusListLoan.add(i);
        if (loanToken.isNotEmpty) {
          loanToken = '$loanToken,${listLoanTokenFilter[i].symbol ?? ''}';
        } else {
          loanToken = listLoanTokenFilter[i].symbol ?? '';
        }
      }
    }
    collateralToken = '';
    for (int i = 0; i < listCollateralTokenFilter.length; i++) {
      if (listCollateralTokenFilter[i].isCheck) {
        statusListCollateral.add(i);
        if (collateralToken.isNotEmpty) {
          collateralToken =
              '$collateralToken,${listCollateralTokenFilter[i].symbol ?? ''}';
        } else {
          collateralToken = listCollateralTokenFilter[i].symbol ?? '';
        }
      }
    }
    statusWallet = textAddressFilter.value;
    statusOpen = isOpen.value;
    statusAll = isAll.value;
    statusAccepted = isAccepted.value;
    statusWithDrawn = isWithDrawn.value;
    status = '';
    if (isAll.value) {
      status = '';
    } else {
      checkStatusId(OPEN.toString(), isOpen.value);
      checkStatusId(ACCEPTED.toString(), isAccepted.value);
      checkStatusId(WITHDRAW.toString(), isWithDrawn.value);
    }
    getListCollateral();
  }

  void checkStatusId(
    String idStatus,
    bool data,
  ) {
    if (data) {
      if (status.isNotEmpty) {
        status = '$status,$idStatus';
      }
    } else {
      status = idStatus;
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
      textAddressFilter.add(statusWallet ?? '');
      isAll.add(statusAll);
      isOpen.add(statusOpen);
      isAccepted.add(statusAccepted);
      isWithDrawn.add(statusWithDrawn);
    }
  }

  void funReset() {
    textAddressFilter.add(S.current.all);
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
    isWithDrawn.add(false);
    isAccepted.add(false);
    isOpen.add(false);
    isAll.add(false);
  }

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

  String checkNullAddressWallet(String address) {
    String addressWallet = '';
    if (address.length < 20) {
      addressWallet = address;
    } else {
      addressWallet = address.formatAddressWalletConfirm();
    }
    return addressWallet;
  }

  Future<void> getListWallet() async {
    getTokenInf();
    final Result<List<WalletAddressModel>> result =
        await _walletAddressRepository.getListWalletAddress();
    result.when(
      success: (res) {
        if (res.isEmpty) {
          checkWalletAddress = false;
        } else {
          statusWallet = res.first.walletAddress;
          if (res.length < 2) {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            checkWalletAddress = false;
          } else {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            checkWalletAddress = true;
          }
          refreshPosts();
        }
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getListWallet();
        }
      },
    );
  }

  String checkAddress(String address) {
    String data = '';
    if (address == S.current.all) {
      data = S.current.all;
    } else {
      if (address.length > 20) {
        data = address.formatAddressWalletConfirm();
      }
    }
    return data;
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

  Future<void> getListCollateral() async {
    showLoading();
    emit(CollateralMyAccLoading());
    final Result<List<CollateralResultModel>> response =
        await _pawnService.getListCollateralMyAcc(
      page: page.toString(),
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      walletAddress: statusWallet,
      sort: 'id,desc',
      //todo
      collateralCurrencySymbol: loanToken,
      status: status,
      supplyCurrencySymbol: collateralToken,
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
          CollateralMyAccSuccess(
            CompleteType.SUCCESS,
            listCollateral: response,
          ),
        );
      },
      error: (error) {
        emit(
          CollateralMyAccSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }
}
