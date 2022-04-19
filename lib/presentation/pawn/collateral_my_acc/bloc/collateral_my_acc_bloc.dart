import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/wallet_address_model.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
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
    refreshPosts();
  }

  String mess = '';
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  List<CollateralResultModel> list = [];
  List<NftMarket> listNFT = [];

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
  BehaviorSubject<String> textAddressFilter = BehaviorSubject.seeded('all');
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
  String textAddress = 'all';

  void chooseAddressFilter(String address) {
    textAddressFilter.sink.add(
      address,
    );
    isChooseAcc.sink.add(false);
  }

  void check(String title) {
    if (title == S.current.all) {
      isOpen.add(false);
      isAccepted.add(false);
      isWithDrawn.add(false);
      isAll.add(true);
    } else if (title == S.current.open) {
      isOpen.add(true);
      isAccepted.add(false);
      isWithDrawn.add(false);
      isAll.add(false);
    } else if (title == S.current.accepted) {
      isOpen.add(false);
      isAccepted.add(true);
      isWithDrawn.add(false);
      isAll.add(false);
    } else if (title == S.current.withdraw) {
      isOpen.add(false);
      isAccepted.add(false);
      isWithDrawn.add(true);
      isAll.add(false);
    }
  }

  void funFilter() {
    list.clear();
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
    if (textAddressFilter.value == S.current.all) {
      textAddress = 'all';
    } else {
      textAddress = textAddressFilter.value;
    }

    if (isAll.value) {
      status = '';
    } else if (isAccepted.value) {
      status = ACCEPTED.toString();
    } else if (isWithDrawn.value) {
      status = WITHDRAW.toString();
    } else if (isOpen.value) {
      status = OPEN.toString();
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
    if (listAcc.length > 2) {
      textAddressFilter.add(S.current.all);
    }
    for (int i = 0; i < listCollateralTokenFilter.length; i++) {
      if (listCollateralTokenFilter[i].isCheck) {
        listCollateralTokenFilter[i].isCheck = false;
      }
    }
    for (int i = 0; i < listLoanTokenFilter.length; i++) {
      if (listLoanTokenFilter[i].isCheck) {
        listLoanTokenFilter[i].isCheck = false;
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
    final Result<List<WalletAddressModel>> result =
        await _walletAddressRepository.getListWalletAddress();
    getTokenInf();
    result.when(
      success: (res) {
        if (res.isEmpty) {
          checkWalletAddress = false;
        } else {
          statusWallet = PrefsService.getCurrentWalletCore();
          if (res.length < 2) {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            textAddress = PrefsService.getCurrentWalletCore();
            checkWalletAddress = false;
            textAddressFilter.add(PrefsService.getCurrentWalletCore());
          } else {
            for (final element in res) {
              if (element.walletAddress?.isNotEmpty ?? false) {
                listAcc.add(element.walletAddress ?? '');
              }
            }
            textAddress = 'all';
            checkWalletAddress = true;
            textAddressFilter.add(S.current.all);
          }
        }
      },
      error: (error) {
        textAddress = PrefsService.getCurrentWalletCore();
        textAddressFilter.add(PrefsService.getCurrentWalletCore());
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

  Future<void> refreshPostsNft({
    String? type,
    String? borrowerWalletAddress,
    String? name,
  }) async {
    if (!refresh) {
      showLoading();
      page = 0;
      refresh = true;
      await getListNft(
        type: type,
        borrowerWalletAddress: borrowerWalletAddress,
        name: name,
      );
    }
  }
  bool loadMore = false;
  bool canLoadMoreListNft = true;
  bool refresh = false;

  void loadMorePostsNft({
    String? type,
    String? borrowerWalletAddress,
    String? name,
  }) {
    if (!loadMore) {
      page += 1;
      loadMore = true;
      getListNft(
        type: type,
        borrowerWalletAddress: borrowerWalletAddress,
        name: name,
      );
    }
  }

  Future<void> getListNft({
    String? type,
    String? borrowerWalletAddress,
    String? name,
  }) async {
    showLoading();
    final Result<List<NftMarket>> response =
        await _pawnService.getListNftContract(
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      name: name,
      page: page.toString(),
      type: type,
      borrowerWalletAddress: textAddress,
      status: status,
    );
    response.when(
      success: (res) {
        emit(
          BorrowListMyAccNFTSuccess(
            CompleteType.SUCCESS,
            listNFT: res,
          ),
        );
      },
      error: (err) {
        emit(
          BorrowListMyAccNFTSuccess(
            CompleteType.ERROR,
            message: err.message,
          ),
        );
      },
    );
  }

  Future<void> getListCollateral() async {
    showLoading();
    emit(CollateralMyAccLoading());
    final Result<List<CollateralResultModel>> response =
        await _pawnService.getListCollateralMyAcc(
      page: page.toString(),
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      walletAddress: textAddress,
      sort: 'id,desc',
      //todo
      collateralCurrencySymbol: collateralToken,
      status: status,
      supplyCurrencySymbol: loanToken,
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
        if (error.code == CODE_ERROR_AUTH) {
          getListCollateral();
        }
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
