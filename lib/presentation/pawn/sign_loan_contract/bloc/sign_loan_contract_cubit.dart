import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'sign_loan_contract_state.dart';

class SignLoanContractCubit extends BaseCubit<SignLoanContractState> {
  SignLoanContractCubit() : super(SignLoanContractInitial());

  BehaviorSubject<ModelToken> tokenStream =
      BehaviorSubject.seeded(ModelToken.init());
  BehaviorSubject<String> focusTextField = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorCollateral = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorMessage = BehaviorSubject.seeded('');
  BehaviorSubject<String> errorDuration = BehaviorSubject.seeded('');
  BehaviorSubject<bool> emailNotification = BehaviorSubject.seeded(true);
  BehaviorSubject<bool> chooseExisting = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> enableButton = BehaviorSubject.seeded(false);
  BehaviorSubject<String> interestEstimation = BehaviorSubject.seeded('');
  BehaviorSubject<String> loanEstimation = BehaviorSubject.seeded('');

  String wallet = '';
  String? collateralCached;
  String? messageCached;
  String? durationCached;
  String? durationCachedType;
  ModelToken? collateralTokenCached;
  ModelToken? loanTokenCached;

  void enableButtonRequest(
    String message,
    String collateral,
    String duration,
  ) {
    if (errorCollateral.value == '' &&
        errorMessage.value == '' &&
        errorDuration.value == '' &&
        message != '' &&
        collateral != '' &&
        duration != '') {
      enableButton.add(true);
    } else {
      enableButton.add(false);
    }
  }

  double exchangeRate(String symbol) {
    return checkShow
        .where((element) => element.nameShortToken == symbol)
        .first
        .exchangeRate;
  }

  PawnshopPackage pawnshopPackage = PawnshopPackage();

  void loanE(
    double collateral,
    ModelToken collateralToken,
    num loanToValue,
    String loanToken,
  ) {
    double loanE = 0;
    loanE = collateral *
        collateralToken.exchangeRate *
        loanToValue /
        exchangeRate(loanToken) /
        100;
    if (loanE < (pawnshopPackage.allowedLoanMin ?? 0)) {
      errorCollateral.add('Amount need to larger than the minimum loan');
    }
    if (loanE > (pawnshopPackage.allowedLoanMax ?? 0)) {
      errorCollateral.add('Amount need to smaller than the maximum loan');
    }
    loanEstimation.add(formatPrice.format(loanE));
  }

  void interestE(
    num loanE,
    String loanToken,
    num interestRate,
    String durationType,
    int duration,
    String repaymentToken,
  ) {
    double interestE = 0;
    if (durationType == S.current.week) {
      interestE = loanE *
          exchangeRate(loanToken) *
          interestRate *
          duration *
          7 /
          365 /
          100 /
          exchangeRate(repaymentToken);
    } else {
      interestE = loanE *
          exchangeRate(loanToken) *
          interestRate *
          duration *
          30 /
          365 /
          100 /
          exchangeRate(repaymentToken);
    }
    interestEstimation.add(formatPrice.format(interestE));
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
        await checkShowCollateral(collateralAccepted);
        await getBalanceOFToken(listTokenCollateral);
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

  final Web3Utils client = Web3Utils();

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
    for (final element in listTokenCollateral) {
      if (element.nameShortToken.toLowerCase() == symbol.toLowerCase()) {
        balance = element.balanceToken;
      }
    }
    return balance;
  }

  String getMax(String symbol) {
    double balance = 0;
    for (final element in listTokenCollateral) {
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

  Future<String> getCreateCryptoCollateral({
    required String collateralAddress,
    required String packageID,
    required String amount,
    required String loanToken,
    required String durationQty,
    required int durationType,
  }) async {
    final String hexString = await client.getCreateCryptoCollateralData(
      collateralAddress: collateralAddress,
      packageId: packageID,
      amount: amount,
      loanAsset: loanToken,
      expectedDurationQty: durationQty,
      expectedDurationType: durationType,
    );
    return hexString;
  }

  BorrowRepository get _repo => Get.find();

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
      'collateral': collateral,
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
    bool checkSuccess = false;
    final Result<String> code = await _repo.confirmCollateralToBe(map: map);
    code.when(
      success: (res) {
        if (res == 'success') {
          checkSuccess = true;
        }
      },
      error: (error) {},
    );
    return checkSuccess;
  }

  void checkDuration(
    String value,
    String typeDuration,
  ) {
    if (typeDuration == S.current.month) {
      if (pawnshopPackage.durationQtyType == 1) {
        if (int.parse(value) < (pawnshopPackage.durationQtyTypeMin ?? 0)) {
          errorDuration.add('Out of range');
        } else if (int.parse(value) >
            (pawnshopPackage.durationQtyTypeMax ?? 0)) {
          errorDuration.add('Out of range');
        } else {
          durationCached = value;
          errorDuration.add('');
        }
      } else {
        if (int.parse(value) * 4 < (pawnshopPackage.durationQtyTypeMin ?? 0)) {
          errorDuration.add('Out of range');
        } else if (int.parse(value) * 4 >
            (pawnshopPackage.durationQtyTypeMax ?? 0)) {
          errorDuration.add('Out of range');
        } else {
          durationCached = value;
          errorDuration.add('');
        }
      }
    } else {
      if (pawnshopPackage.durationQtyType == 1) {
        if (int.parse(value) < (pawnshopPackage.durationQtyTypeMin ?? 0) * 4) {
          errorDuration.add('Out of range');
        } else if (int.parse(value) >
            (pawnshopPackage.durationQtyTypeMax ?? 0) * 4) {
          errorDuration.add('Out of range');
        } else {
          durationCached = value;
          errorDuration.add('');
        }
      } else {
        if (int.parse(value) < (pawnshopPackage.durationQtyTypeMin ?? 0)) {
          errorDuration.add('Out of range');
        } else if (int.parse(value) >
            (pawnshopPackage.durationQtyTypeMax ?? 0)) {
          errorDuration.add('Out of range');
        } else {
          durationCached = value;
          errorDuration.add('');
        }
      }
    }
  }
}
