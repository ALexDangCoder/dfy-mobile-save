import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:meta/meta.dart';
import 'package:r_crypto/r_crypto.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../main.dart';

part 'connect_wallet_dialog_state.dart';

enum LoginStatus { NEED_CONNECT_BY_DIALOG, NEED_LOGIN, NEED_REGISTER, LOGGED }

extension LoginStatusToString on LoginStatus {
  String convertToContentDialog() {
    switch (this) {
      case LoginStatus.NEED_REGISTER:
        return S.current.dont_have_wallet;
      case LoginStatus.NEED_LOGIN:
        return S.current.need_login;
      default:
        return '';
    }
  }

  String convertToContentRightButton() {
    switch (this) {
      case LoginStatus.NEED_REGISTER:
        return S.current.create;
      case LoginStatus.NEED_LOGIN:
        return S.current.login;
      default:
        return '';
    }
  }
}

class ConnectWalletDialogCubit extends BaseCubit<ConnectWalletDialogState> {
  ConnectWalletDialogCubit() : super(ConnectWalletDialogInitial());

  Wallet? wallet;

  double? balance;

  BehaviorSubject<bool> isHaveWalletSubject = BehaviorSubject();

  BehaviorSubject<String> signatureSubject = BehaviorSubject();

  Stream<bool> get isHaveWalletStream => isHaveWalletSubject.stream;

  BehaviorSubject<LoginStatus> loginStatusSubject = BehaviorSubject();

  Stream<String> get signatureStream => signatureSubject.stream;

  Stream<LoginStatus> get loginStatusStream => loginStatusSubject.stream;

  Future<void> getListWallet() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {
      //nothing
    }
  }

  Web3Utils client = Web3Utils();

  Future<void> getBalance({required String walletAddress}) async {
    balance = await client.getBalanceOfBnb(ofAddress: walletAddress);
  }

  int randomAvatar() {
    final Random rd = Random();
    return rd.nextInt(10);
  }

  Future<void> checkStatusLogin() async {
    final walletAddressCore = PrefsService.getCurrentWalletCore();
    final walletConnectBE = PrefsService.getCurrentBEWallet();

    //Đã login core - chưa login BE
    if (walletAddressCore.isNotEmpty && walletConnectBE.isEmpty) {
      loginStatusSubject.sink.add(LoginStatus.NEED_CONNECT_BY_DIALOG);
      return;
    }

    //Đã login core - đã login BE
    if (walletAddressCore.isNotEmpty && walletConnectBE.isNotEmpty) {
      loginStatusSubject.sink.add(LoginStatus.LOGGED);
      return;
    }

    //Có ví, chưa login core - chưa login BE
    if (walletAddressCore.isEmpty &&
        walletConnectBE.isEmpty &&
        (isHaveWalletSubject.value == true)) {
      loginStatusSubject.sink.add(LoginStatus.NEED_LOGIN);
      return;
    }

    //Không có ví
    if (!isHaveWalletSubject.value) {
      loginStatusSubject.sink.add(LoginStatus.NEED_REGISTER);
      return;
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isNotEmpty) {
          isHaveWalletSubject.sink.add(true);
          wallet = Wallet.fromJson(data.first);
        } else {
          isHaveWalletSubject.sink.add(false);
        }
        break;
      case 'signWalletCallback':
        final String signature = await methodCall.arguments['signature'];
        signatureSubject.sink.add(signature);
        break;
      default:
        break;
    }
  }

  LoginRepository get _loginRepo => Get.find();

  Future<void> loginAndSaveInfo({
    required String walletAddress,
    required String signature,
  }) async {
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
      },
      error: (err) {},
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
    } on PlatformException {
      //
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

  void dispose() {
    isHaveWalletSubject.close();
    loginStatusSubject.close();
  }
}
