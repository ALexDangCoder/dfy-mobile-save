import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/request/pawn/borrow/nft_send_loan_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/model/pawn/borrow/nft_on_request_loan_model.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/domain/repository/market_place/nft_market_repo.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/app_utils.dart' as utils;
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'send_loan_request_state.dart';

class SendLoanRequestCubit extends BaseCubit<SendLoanRequestState> {
  SendLoanRequestCubit() : super(SendLoanRequestInitial());

  BehaviorSubject<ModelToken> tokenStream =
      BehaviorSubject.seeded(ModelToken.init());
  BehaviorSubject<String> focusTextField = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorCollateral = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorMessage = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorDuration = BehaviorSubject.seeded('');
  BehaviorSubject<bool> emailNotification = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> chooseExisting = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> enableButton = BehaviorSubject.seeded(false);
  BehaviorSubject<int> tabIndex = BehaviorSubject.seeded(0);

  String wallet = '';
  String? collateralCached;
  String? messageCached;
  String? durationCached;
  String? durationCachedType;
  ModelToken? collateralTokenCached;
  ModelToken? loanTokenCached;

  final Web3Utils client = Web3Utils();

  void enableButtonRequest(
    String amount,
    String message,
    String duration,
  ) {
    if (errorCollateral.value == '' &&
        errorMessage.value == '' &&
        errorDuration.value == '' &&
        amount != '' &&
        message != '' &&
        duration != '') {
      enableButton.add(true);
    } else {
      enableButton.add(false);
    }
  }

  Stream<ModelToken> getTokenRealtime(List<ModelToken> listModelToken) async* {
    for (int i = 0; i < listModelToken.length; i++) {
      yield listModelToken[i];
    }
  }

  List<AcceptableAssetsAsCollateral> collateralAccepted = [];

  Future<void> checkShowCollateral(
    List<AcceptableAssetsAsCollateral> collateralAccepted,
  ) async {
    for (final element in collateralAccepted) {
      for (final item in checkShow) {
        if (element.symbol?.toLowerCase() ==
            item.nameShortToken.toLowerCase()) {
          listTokenCollateral.add(item);
        }
      }
    }
    await getBalanceOFToken(listTokenCollateral);
    // for (final item in checkShow) {
    //   if (item.nameShortToken == DFY || item.nameShortToken == BNB) {
    //     listTokenCollateral.add(item);
    //   }
    // }
  }

  List<ModelToken> listTokenFromWalletCore = [];
  List<ModelToken> listTokenCollateral = [];
  final List<ModelToken> checkShow = [];

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getTokensCallback':
        listTokenFromWalletCore.clear();
        final List<dynamic> data = methodCall.arguments;
        for (final element in data) {
          checkShow.add(ModelToken.fromWalletCore(element));
        }
        for (final element in checkShow) {
          if (element.isShow) {
            listTokenFromWalletCore.add(element);
          }
        }
        await checkShowCollateral(collateralAccepted);
        emit(GetWalletSuccess());
        break;
      default:
        break;
    }
  }

  void getTokens(String walletAddress) {
    try {
      final data = {
        'walletAddress': walletAddress,
      };
      trustWalletChannel.invokeMethod('getTokens', data);
    } on PlatformException {
      //nothing
    }
  }

  Future<void> getBalanceOFToken(List<ModelToken> list) async {
    await for (final value in getTokenRealtime(list)) {
      if (value.nameShortToken != 'BNB') {
        value.balanceToken = await client.getBalanceOfToken(
          ofAddress: wallet,
          tokenAddress: value.tokenAddress,
        );
      } else {
        value.balanceToken = await client.getBalanceOfBnb(
          ofAddress: wallet,
        );
      }
    }
  }

  double getMaxBalance(String symbol) {
    double balance = 0;
    for (final element in listTokenFromWalletCore) {
      if (element.nameShortToken.toLowerCase() == symbol.toLowerCase()) {
        balance = element.balanceToken;
      }
    }
    return balance;
  }

  String getMax(String symbol) {
    double balance = 0;
    for (final element in listTokenFromWalletCore) {
      if (element.nameShortToken.toLowerCase() == symbol.toLowerCase()) {
        balance = element.balanceToken;
      }
    }
    return formatPrice.format(balance);
  }

  bool hasEmail = false;

  bool getLoginState() {
    final account = PrefsService.getWalletLogin();
    final Map<String, dynamic> mapLoginState = jsonDecode(account);
    if (mapLoginState.stringValueOrEmpty('accessToken') != '') {
      wallet = PrefsService.getCurrentBEWallet();
      getTokens(wallet);
      final userInfo = PrefsService.getUserProfile();
      final Map<String, dynamic> mapProfileUser = jsonDecode(userInfo);
      if (mapProfileUser.stringValueOrEmpty('email') != '') {
        hasEmail = true;
      }
      return true;
    } else {
      emit(NoLogin());
      return false;
    }
  }

  final Web3Utils _client = Web3Utils();

  BorrowRepository get _repo => Get.find();

  Future<String> getCreateCryptoCollateral({
    required String collateralAddress,
    required String packageID,
    required String amount,
    required String loanToken,
    required String durationQty,
    required int durationType,
  }) async {
    final String hexString = await _client.getCreateCryptoCollateralData(
      collateralAddress: collateralAddress,
      packageId: packageID,
      amount: amount,
      loanAsset: loanToken,
      expectedDurationQty: durationQty,
      expectedDurationType: durationType,
    );
    return hexString;
  }

  Future<bool> pushSendNftToBE({
    required String amount,
    required String bcPackageId,
    required String collateral,
    required String collateralId,
    required String description,
    required String duration,
    required String durationType,
    required String packageId,
    required String pawnshopType,
    required String txId,
    required String supplyCurrency,
    required String walletAddress,
  }) async {
    final Map<String, String> map = {
      'amount': amount,
      'bcPackageId': bcPackageId,
      'collateral': collateral,
      'collateralId': collateralId,
      'description': description,
      'expected_loan_duration_time': duration,
      'expected_loan_duration_type': durationType,
      'pawnShopPackageId': packageId,
      'pawnShopPackageType': pawnshopType,
      'supply_currency': supplyCurrency,
      'txid': txId,
      'wallet_address': walletAddress,
    };
    bool checkSuccess = false;
    final Result<String> code = await _repo.confirmCollateralToBe(map: map);
    code.when(
        success: (res) {
          if (res == 'success') {
            checkSuccess = true;
          }
        },
        error: (error) {});
    return checkSuccess;
  }

  ///Huy send loan nft

  void validateMessage(String value) {
    if (value.isEmpty) {
      mapValidate['formMess'] = false;
      isShowMessage.sink.add(true);
      txtWarnMess.sink.add('Message is required');
    } else if (value.length > 100) {
      mapValidate['formMess'] = false;
      isShowMessage.sink.add(true);
      txtWarnMess.sink.add('Maximum length allowed is 100 characters');
    } else {
      mapValidate['formMess'] = true;
      isShowMessage.sink.add(false);
    }
  }

  void validateAmount(String amount) {
    if (amount.isEmpty) {
      mapValidate['formLoan'] = false;
      isShowLoanToken.sink.add(true);
      txtWarnLoan.sink.add('Expected loan is required');
    } else if (!utils.isValidateAmount5(amount)) {
      mapValidate['formLoan'] = false;
      isShowLoanToken.sink.add(true);
      txtWarnLoan.sink.add('Invalid expected loan');
    } else if (amount.length > 100) {
      mapValidate['formLoan'] = false;
      isShowLoanToken.sink.add(true);
      txtWarnLoan.sink.add('Maximum length allowed is 100 characters');
    } else {
      nftRequest.loanAmount = double.parse(amount);
      mapValidate['formLoan'] = true;
      isShowLoanToken.sink.add(false);
    }
  }

  void validateDuration(String value, {bool isMonth = true}) {
    if (!isMonth) {
      //isWeek
      if (value.isEmpty) {
        mapValidate['formDuration'] = false;
        isShowDuration.sink.add(true);
        txtWarnDuration.sink.add('Duration is required');
      } else if (int.parse(value) > 1200) {
        mapValidate['formDuration'] = false;
        isShowDuration.sink.add(true);
        txtWarnDuration.sink
            .add('Duration by week cannot be greater than 5,200');
      } else {
        nftRequest.durationTime = int.parse(value);
        mapValidate['formDuration'] = true;
        isShowDuration.add(false);
      }
    } else {
      //isMonth
      if (value.isEmpty) {
        mapValidate['formDuration'] = false;
        isShowDuration.sink.add(true);
        txtWarnDuration.sink.add('Duration is required');
      } else if (int.parse(value) > 1200) {
        mapValidate['formDuration'] = false;
        isShowDuration.sink.add(true);
        txtWarnDuration.sink
            .add('Duration by month cannot be greater than 1,200');
      } else {
        nftRequest.durationTime = int.parse(value);
        mapValidate['formDuration'] = true;
        isShowDuration.add(false);
      }
    }
  }

  Map<String, bool> mapValidate = {
    'formLoan': false,
    'formMess': false,
    'formDuration': false,
    'tick': true,
    'chooseNFT': false,
  };

  final NftSendLoanRequest nftRequest = NftSendLoanRequest(
    loanSymbol: DFY,
  );

  //THIS VAR SAVE INFOR NFT WIDGET
  NftMarket nftMarketConfirm = NftMarket();

  void validateAll() {
    if (mapValidate.containsValue(false)) {
      isEnableSendRqNft.sink.add(false);
    } else {
      isEnableSendRqNft.sink.add(true);
    }
  }

  BehaviorSubject<bool> isMonthForm = BehaviorSubject<bool>();
  BehaviorSubject<bool> isEnableSendRqNft = BehaviorSubject<bool>();
  BehaviorSubject<bool> tickBoxSendRqNft = BehaviorSubject<bool>();
  List<Map<String, dynamic>> listDropDownToken = [];
  List<TokenInf> listTokenSupport = [];
  List<Map<String, dynamic>> listDropDownDuration = [
    {
      'label': 'month',
      'value': 'month',
    },
    {
      'label': 'week',
      'value': 'week',
    },
  ];

  ///warning form
  BehaviorSubject<bool> isShowMessage = BehaviorSubject<bool>();
  BehaviorSubject<bool> isShowLoanToken = BehaviorSubject<bool>();
  BehaviorSubject<bool> isShowDuration = BehaviorSubject<bool>();
  BehaviorSubject<String> txtWarnMess = BehaviorSubject<String>();
  BehaviorSubject<String> txtWarnLoan = BehaviorSubject<String>();
  BehaviorSubject<String> txtWarnDuration = BehaviorSubject<String>();

  BehaviorSubject<Map<String, dynamic>> tokenAfterChooseNft =
      BehaviorSubject<Map<String, dynamic>>();

  void getTokensRequestNft() {
    if (listTokenSupport.isNotEmpty || listDropDownToken.isNotEmpty) {
      listTokenSupport.clear();
      listDropDownToken.clear();
    }
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
    listDropDownToken.add({
      'label': DFY,
      'value': 1,
      'addressToken': Get.find<AppConstants>().contract_defy,
      'icon': SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.network(
          ImageAssets.getSymbolAsset(
            DFY,
          ),
        ),
      )
    });
    for (final element in listTokenSupport) {
      if (element.symbol == USDT ||
          element.symbol == 'DAI' ||
          element.symbol == 'USDC' ||
          element.symbol == 'BUSD') {
        listDropDownToken.add({
          'label': element.symbol,
          'value': element.id,
          'addressToken': element.address,
          'icon': SizedBox(
            width: 20.w,
            height: 20.h,
            child: Image.network(
              ImageAssets.getSymbolAsset(
                element.symbol ?? DFY,
              ),
            ),
          )
        });
      }
    }
  }

  ///autoFill data when choosing data
  BehaviorSubject<NftMarket?> nftMarketFill = BehaviorSubject<NftMarket>();

  BehaviorSubject<bool> isShowIcCloseSearch = BehaviorSubject<bool>();

  ///Call API
  String message = '';
  int page = 0;
  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;
  List<ContentNftOnRequestLoanModel> contentNftOnSelect = [];

  NftMarketRepository get _nftRepo => Get.find();

  Future<void> getSelectNftCollateral(
    String? walletAddress, {
    String? name,
    String? nftType,
    bool isSearch = false,
  }) async {
    if (isSearch) {
      contentNftOnSelect.clear();
      page = 0;
    }
    showLoading();
    final Result<List<ContentNftOnRequestLoanModel>> result =
        await _repo.getListNftOnLoanRequest(
      walletAddress: walletAddress,
      page: page.toString(),
      name: name,
      // nftType: nftType ?? '0',
      // size: '6',
    );
    result.when(
      success: (res) {
        emit(
          ListSelectNftCollateralGetApi(
            CompleteType.SUCCESS,
            list: res,
          ),
        );
        showContent();
      },
      error: (error) {
        emit(
          ListSelectNftCollateralGetApi(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }

  Future<void> loadMoreGetListNftCollateral(
    String walletAddress, {
    String? name,
    String? nftType,
  }) async {
    if (loadMore == false) {
      // showLoading();
      page += 1;
      canLoadMoreList = true;
      loadMore = true;
      await getSelectNftCollateral(walletAddress, nftType: nftType, name: name);
    } else {
      //nothing
    }
  }

  String getCurrentWallet() {
    return PrefsService.getCurrentBEWallet();
  }

  Future<void> getListNft({
    String? name,
    String? walletAddress,
  }) async {
    final Result<List<NftMarket>> result = await _nftRepo.getListNftMyAcc(
      status: '0',
      name: name,
      nftType: '1',
      collectionId: '',
      page: page.toString(),
    );

    result.when(
      success: (res) {
        //todo
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getListNft();
        }
      },
    );
  }

  Future<void> postNftToServer() async {
    emit(SubmittingNft());
    final result = await _repo.postNftToServer(request: nftRequest);
    result.when(success: (res) {
      if (res.error == 'success') {
        emit(SubmitNftSuccess(CompleteType.SUCCESS));
      } else {
        emit(SubmitNftSuccess(CompleteType.ERROR));
      }
    }, error: (error) {
      emit(SubmitNftSuccess(CompleteType.ERROR));
    });
  }

  Future<void> refreshGetListNftCollateral(String walletAddress) async {
    canLoadMoreList = true;
    if (refresh == false) {
      // showLoading();
      page = 0;
      refresh = true;
      await getSelectNftCollateral(walletAddress);
      getListNft();
    } else {
      //nothing
    }
  }
}
