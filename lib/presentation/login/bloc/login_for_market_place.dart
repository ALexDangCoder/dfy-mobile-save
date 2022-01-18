import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:r_crypto/r_crypto.dart';

import '../../../main.dart';
import 'login_cubit.dart';

extension LoginForMarketPlace on LoginCubit {
  LoginRepository get _loginRepo => Get.find();


  Future<void> loginAndSaveInfo({required String walletAddress, required String signature}) async {
    final result = await _loginRepo.login(signature, walletAddress);
    await result.when(
      success: (res) async {
        await PrefsService.saveWalletLogin(
          loginToJson(res),
        );
      },
      error: (err) {
        log(err.message);
        showError();
      },
    );
  }

  Future<void> signWallet({
    required String walletAddress,
  }) async {
    try {
      final TransactionCountResponse trans =
          await Web3Utils().getTransactionCount(
        address: walletAddress,
      );
      if(trans.isSuccess){
        final List<int> listNonce = trans.count.toString().codeUnits;
        final Uint8List bytesNonce = Uint8List.fromList(listNonce);
        final List<int> listSha3 =
        rHash.hashList(HashType.KECCAK_256, bytesNonce);
        final Uint8List bytesSha3 = Uint8List.fromList(listSha3);
        final data = {
          'walletAddress': walletAddress,
          'bytesSha3': bytesSha3,
        };
        unawaited(trustWalletChannel.invokeMethod('signWallet', data));
      }else{
        showError();
      }
    } on PlatformException {
      //
    }
  }

  //getListWallets
  void getWallet() {
    try {
      final data = {};
      trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {
      //
    }
  }
}
