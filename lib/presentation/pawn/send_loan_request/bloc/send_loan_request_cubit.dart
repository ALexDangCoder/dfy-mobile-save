import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/receive_token/ui/receive_token.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'send_loan_request_state.dart';

class SendLoanRequestCubit extends BaseCubit<SendLoanRequestState> {
  SendLoanRequestCubit() : super(SendLoanRequestInitial());

  BehaviorSubject<ModelToken> tokenStream =
      BehaviorSubject.seeded(ModelToken.init());
  BehaviorSubject<String> focusTextField =
  BehaviorSubject.seeded('');
  BehaviorSubject<bool> emailNotification =
  BehaviorSubject.seeded(true);
  BehaviorSubject<bool> chooseExisting =
  BehaviorSubject.seeded(false);
  BehaviorSubject<int> tabIndex =
  BehaviorSubject.seeded(0);

  String wallet = '';

  final Web3Utils client = Web3Utils();

  Stream<ModelToken> getTokenRealtime(List<ModelToken> listModelToken) async* {
    for (int i = 0; i < listModelToken.length; i++) {
      yield listModelToken[i];
    }
  }

  List<ModelToken> listTokenFromWalletCore = [

  ];
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

  String getMax(String symbol) {
    double balance = 0;
    for (final element in listTokenFromWalletCore) {
      if (element.nameShortToken.toLowerCase() == symbol.toLowerCase()) {
        balance = element.balanceToken;
      }
    }
    return formatPrice.format(balance);
  }

  bool getLoginState() {
    final account = PrefsService.getWalletLogin();
    final Map<String, dynamic> mapLoginState = jsonDecode(account);
    if (mapLoginState.stringValueOrEmpty('accessToken') != '') {
      wallet = PrefsService.getCurrentBEWallet();
      getTokens(wallet);
      return true;
    } else {
      emit(NoLogin());
      return false;
    }
  }
}
