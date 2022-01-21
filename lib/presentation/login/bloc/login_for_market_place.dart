import 'dart:async';
import 'dart:typed_data';

import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:r_crypto/r_crypto.dart';

import '../../../main.dart';
import 'login_cubit.dart';

extension LoginForMarketPlace on LoginCubit {
  LoginRepository get _loginRepo => Get.find();

  Future<void> loginAndSaveInfo(
      {required String walletAddress, required String signature}) async {
    final result = await _loginRepo.login(signature, walletAddress);

    await result.when(
      success: (res) async {
        await PrefsService.saveWalletLogin(
          loginToJson(res),
        );
        await PrefsService.saveCurrentBEWallet(
          walletAddress,
        );
        await getUserProfile();
        isSaveInfoSuccessSubject.sink.add(true);
      },
      error: (err) {
        isSaveInfoSuccessSubject.sink.add(false);
      },
    );
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

  Future<void> getSignature({required String walletAddress}) async {
    try {
      showLoading();
      final result = await _loginRepo.getNonce(
        walletAddress,
      );
      result.when(
        success: (res) {
          final String nonce = res.data ?? '';
          final List<int> listNonce = nonce.codeUnits;
          final Uint8List bytesNonce = Uint8List.fromList(listNonce);
          final List<int> listSha3 =
              rHash.hashList(HashType.KECCAK_256, bytesNonce);
          final Uint8List bytesSha3 = Uint8List.fromList(listSha3);
          final data = {
            'walletAddress': walletAddress,
            'bytesSha3': bytesSha3,
          };
          unawaited(trustWalletChannel.invokeMethod('signWallet', data));
        },
        error: (error) {
          showError();
        },
      );
    } on PlatformException catch (e) {
      throw AppException(
        S.current.something_went_wrong,
        e.message.toString(),
      );

    }
  }

  Future<void> getUserProfile() async {
    final result = await _loginRepo.getUserProfile();
    await result.when(
      success: (res) async {
        final UserProfileModel userProfile =
            UserProfileModel.fromJson(res.data ?? {});
        await PrefsService.saveUserProfile(userProfileToJson(userProfile));
      },
      error: (err) async {
        await PrefsService.saveUserProfile(
          PrefsService.userProfileEmpty(),
        );
      },
    );
  }
}
