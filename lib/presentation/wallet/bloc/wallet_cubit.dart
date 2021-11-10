import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  final String addressWallet = '0xe77c14cdF13885E1909149B6D9B65734aefDEAEf';
  String formatAddressWallet = '';
  bool checkLogin = false;

  Future<void> getAddressWallet() async {}

  void formatAddress(String address) {
    final splitAddress = address.split('');
    formatAddressWallet = '${splitAddress[0]}'
        '${splitAddress[1]}${splitAddress[2]}'
        '${splitAddress[3]}${splitAddress[6]}'
        '${splitAddress[5]}...${splitAddress[37]}'
        '${splitAddress[38]}${splitAddress[39]}'
        '${splitAddress[40]}';
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    Object objToken = {};
    Object objNFT = {};
    switch (methodCall.method) {
      case 'getListShowedTokenCallback':
        objToken = methodCall.arguments['TokenObject'];
        break;
      case 'getListShowedNftCallback':
        objNFT = methodCall.arguments;
        break;
      default:
        break;
    }
  }

  Future<void> getListToken(String walletAddress, String password) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'password': password,
      };
      await trustWalletChannel.invokeMethod('getListShowedToken', data);
    } on PlatformException {
      log(e);
    }
  }

  Future<void> getListNFT(String walletAddress,
      {required String password,}) async {
    try {
      final data = {
        'walletAddress': walletAddress,
        'password': password,
      };
      await trustWalletChannel.invokeMethod('getListShowedNft', data);
    } on PlatformException {
      log(e);
    }
  }
  void checkScreen() {
    if(PrefsService.getAppLockConfig() == 'true' && checkLogin == false) {
      checkLogin = true;
    }
    else {
      emit(WalletInitial());
    }
  }
}
