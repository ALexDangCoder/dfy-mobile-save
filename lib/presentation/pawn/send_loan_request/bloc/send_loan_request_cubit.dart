import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/app_utils.dart';
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
  BehaviorSubject<bool> emailNotification = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> chooseExisting = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> enableButton = BehaviorSubject.seeded(false);
  BehaviorSubject<int> tabIndex = BehaviorSubject.seeded(0);

  String wallet = '';

  final Web3Utils client = Web3Utils();

  void enableButtonRequest() {
    if (errorCollateral.value == '' && errorMessage.value == '' &&
        errorDuration.value == '') {
      enableButton.add(true);
    }
    else {
      enableButton.add(false);
    }
  }

  Stream<ModelToken> getTokenRealtime(List<ModelToken> listModelToken) async* {
    for (int i = 0; i < listModelToken.length; i++) {
      yield listModelToken[i];
    }
  }

  List<ModelToken> listTokenFromWalletCore = [];
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
        await getBalanceOFToken(listTokenFromWalletCore);
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
  Future<void> pushSendNftToBE({
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
    final Result<String> code =
    await _repo.confirmCollateralToBe(map: map);
    code.when(success: (res) {}, error: (error) {});
  }

  ///Huy send loan nft
  String? validateMessage(String value) {
    if (value.isEmpty) {
      return 'Message is required';
    } else if (value.length > 100) {
      return 'Maximum length allowed is 100 characters';
    } else {
      return null;
    }
  }

  String? validateAmount(String amount) {
    if (amount.isEmpty) {
      return 'Expected loan is required';
    } else if (amount.length > 100) {
      return 'Maximum length allowed is 100 characters';
    } else if (!isValidateAmount5(amount)) {
      return 'Invalid expected loan';
    } else {
      return null;
    }
  }

  String? validateDuration(String value, {bool isMonth = true}) {
    if (!isMonth) {
      //isWeek
      if (value.isEmpty) {
        return 'Duration is required';
      } else if (int.parse(value) > 1200) {
        return 'Duration by week cannot be greater than 5,200';
      } else {
        return null;
      }
    } else {
      //isMonth
      if (value.isEmpty) {
        return 'Duration is required';
      } else if (int.parse(value) > 1200) {
        return 'Duration by month cannot be greater than 1,200';
      } else {
        return null;
      }
    }
  }

  Map<String, bool> mapValidate = {
    'form': false,
    'tick': false,
    'chooseNFT': false,
  };

  void validateAll() {
    if (mapValidate.containsValue(false)) {
      //false cannot switch screen
    } else {
      //can switch
    }
  }

  BehaviorSubject<bool> isMonthForm = BehaviorSubject<bool>();
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
      'addressToken': Get
          .find<AppConstants>()
          .contract_defy,
      'icon': SizedBox(
        width: 20.w,
        height: 20.h,
        child: Image.asset(
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
            child: Image.asset(
              ImageAssets.getSymbolAsset(
                element.symbol ?? DFY,
              ),
            ),
          )
        });
      }
    }
  }
}
