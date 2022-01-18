import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../main.dart';

part 'connect_wallet_dialog_state.dart';

class ConnectWalletDialogCubit extends Cubit<ConnectWalletDialogState> {
  ConnectWalletDialogCubit() : super(ConnectWalletDialogInitial());
  // BehaviorSubject<bool> isLogin = BehaviorSubject();

  // Future<void> checkLoginStatus() async {
  //   final bool check = await PrefsService.getLoginStatus();
  //   isLogin.sink.add(check);
  // }

  Future<void> getListWallet() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getConfig', data);
    } on PlatformException catch (e) {
      //nothing
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getConfigCallback':
        final bool data = await methodCall.arguments['isWalletExist'];
        try {
          if (data) {
            emit(NeedLoginToUse());
          } else {
            emit(HasNoWallet());
          }
        } catch (e) {
          //
        }
        break;
      default:
        break;
    }
  }
}
