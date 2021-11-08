import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../main.dart';

part 'wallet_state.dart';

class WalletCubit extends BaseCubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  String addressWallet = '0x753EE7D5FdBD248fED37add0C951211E03a7DA15';
  late String formatAddressWallet = '';

  Future<void> getAddressWallet() async {}

  void formatAddress(String address) {
    final splitAddress = address.split('');
    formatAddressWallet = '${splitAddress[0]}'
        '${splitAddress[1]}${splitAddress[2]}'
        '${splitAddress[3]}${splitAddress[4]}'
        '${splitAddress[5]}...${splitAddress[38]}'
        '${splitAddress[39]}${splitAddress[40]}'
        '${splitAddress[41]}';
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
      case 'importWalletCallback':
        print('3: ' + methodCall.arguments.toString());
        print('3: ' + methodCall.arguments['walletAddress'].toString());
        final address = methodCall.arguments['walletAddress'];
        addressWallet = address;
        formatAddress('0x753EE7D5FdBD248fED37add0C951211E03a7DA15');
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

  Future<void> importWallet() async {
    try {
      final data = {
        'type': 'PASS_PHRASE',
        'content':
        'party response give dove tooth master flip video permit game expire token',
        'password': '123456',
      };
      await trustWalletChannel.invokeMethod('importWallet', data);
    } on PlatformException {}
  }
}
