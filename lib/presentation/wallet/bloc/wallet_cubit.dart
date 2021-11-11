import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/main.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import '../../../main.dart';

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  final String addressWallet = '0xe77c14cdF13885E1909149B6D9B65734aefDEAEf';
  String formatAddressWallet = '';
  BehaviorSubject<String> walletName = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isWalletName = BehaviorSubject.seeded(false);
  void getIsWalletName() {
    if (Validator.validateNotNull(walletName.value)) {
      isWalletName.sink.add(true);
    }else{
      isWalletName.sink.add(false);
    }
  }
  bool checkLogin = false;

  Future<void> getAddressWallet() async {}

  void formatAddress(String address) {
    formatAddressWallet = '${address.substring(0, 5)}...${address.substring(
      address.length - 4,
      address.length,
    )}';
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

  Future<void> getListNFT(
    String walletAddress, {
    required String password,
  }) async {
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
    if (PrefsService.getAppLockConfig() == 'true' && checkLogin == false) {
      checkLogin = true;
    } else {
      emit(WalletInitial());
    }
  }
}
