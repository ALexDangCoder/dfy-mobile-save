import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'sign_loan_contract_state.dart';

class SignLoanContractCubit extends BaseCubit<SignLoanContractState> {
  SignLoanContractCubit() : super(SignLoanContractInitial());


  String wallet = '';
  Stream<ModelToken> getTokenRealtime(List<ModelToken> listModelToken) async* {
    for (int i = 0; i < listModelToken.length; i++) {
      yield listModelToken[i];
    }
  }

  List<AcceptableAssetsAsCollateral> collateralAccepted = [];

  void checkShowCollateral(
      List<AcceptableAssetsAsCollateral> collateralAccepted,
      ) {
    // for(final element in collateralAccepted){
    //   for(final item in checkShow) {
    //     if(element.symbol?.toLowerCase() == item.nameShortToken.toLowerCase()){
    //       listTokenCollateral.add(item);
    //     }
    //   }
    // }
    for (final item in checkShow) {
      if (item.nameShortToken == DFY || item.nameShortToken == BNB) {
        listTokenCollateral.add(item);
      }
    }
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
        await getBalanceOFToken(listTokenFromWalletCore);
        checkShowCollateral(collateralAccepted);
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
}
