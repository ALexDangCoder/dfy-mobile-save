import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:r_crypto/r_crypto.dart';

import '../../../main.dart';
import 'login_cubit.dart';

extension LoginForMarketPlace on LoginCubit {
  LoginRepository get _loginRepo => Get.find();

  Future<bool> loginAndSaveInfo({
    required String walletAddress,
    required String signature,
  }) async {
    bool isSuccess = false;
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
        isSuccess = true;
      },
      error: (err) {
        isSuccess = false;
      },
    );
    return isSuccess;
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

  Future<void> getSignature({
    required String walletAddress,
    required BuildContext context,
  }) async {
    try {
      showLoading(context);
      final result = await _loginRepo.getNonce(
        walletAddress,
      );
      hideLoading(context);
      result.when(
        success: (res) {
          final String nonce = res.data ?? '';
          final List<int> listNonce = nonce.codeUnits;
          final Uint8List bytesNonce = Uint8List.fromList(listNonce);
          if (Platform.isIOS) {
            final data = {
              'walletAddress': walletAddress,
              'bytesSha3': listNonce,
            };
            unawaited(trustWalletChannel.invokeMethod('signWallet', data));
          } else {
            final List<int> listSha3 =
                rHash.hashList(HashType.KECCAK_256, bytesNonce);
            final Uint8List bytesSha3 = Uint8List.fromList(listSha3);
            final data = {
              'walletAddress': walletAddress,
              'bytesSha3': bytesSha3,
            };
            unawaited(trustWalletChannel.invokeMethod('signWallet', data));
          }
        },
        error: (error) {
          showErrDialog(
            context: context,
            title: S.current.notify,
            content: S.current.something_went_wrong,
          );
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
