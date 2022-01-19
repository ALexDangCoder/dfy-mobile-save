import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../main.dart';

part 'connect_wallet_dialog_state.dart';

enum LoginStatus { HAVE_WALLET, HAS_NO_WALLET, CHECKING }

extension LoginStatusToString on LoginStatus {
  String convertToContentDialog() {
    switch (this) {
      case LoginStatus.HAS_NO_WALLET:
        return S.current.dont_have_wallet;
      case LoginStatus.HAVE_WALLET:
        return S.current.need_login;
      default:
        return '';
    }
  }

  String convertToContentRightButton() {
    switch (this) {
      case LoginStatus.HAS_NO_WALLET:
        return S.current.create;
      case LoginStatus.HAVE_WALLET:
        return S.current.login;
      default:
        return '';
    }
  }
}

class ConnectWalletDialogCubit extends BaseCubit<ConnectWalletDialogState> {
  ConnectWalletDialogCubit() : super(ConnectWalletDialogInitial());

  BehaviorSubject<LoginStatus> connectStatusSubject = BehaviorSubject();

  BehaviorSubject<bool> isLoginSubject = BehaviorSubject();

  Stream<LoginStatus> get connectStatusStream => connectStatusSubject.stream;

  Stream<bool> get isLoginStream => isLoginSubject.stream;

  Future<void> getListWallet() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getConfig', data);
    } on PlatformException catch (e) {
      //nothing
    }
  }

  Future<void> checkStatusLogin() async {
    final login = PrefsService.getWalletLogin();
    final LoginModel loginModel = loginFromJson(login);
    if (loginModel.accessToken?.isNotEmpty ?? false) {
      isLoginSubject.sink.add(true);
    } else {
      isLoginSubject.sink.add(false);
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getConfigCallback':
        final bool data = await methodCall.arguments['isWalletExist'];
        try {
          if (data) {
            connectStatusSubject.sink.add(LoginStatus.HAVE_WALLET);
          } else {
            connectStatusSubject.sink.add(LoginStatus.HAS_NO_WALLET);
          }
        } catch (e) {
          //
        }
        break;
      default:
        break;
    }
  }

  void dispose(){
    isLoginSubject.close();
    connectStatusSubject.close();
  }
}
