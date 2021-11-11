import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/presentation/create_wallet_first_time/setup_password/helper/validator.dart';
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
    print(objToken);
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
}
