import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

part 'setting_wallet_state.dart';

class SettingWalletCubit extends Cubit<SettingWalletState> {
  SettingWalletCubit() : super(SettingWalletInitial());

  bool isSuccess = false;

  //this variable is current value of AppLock get from SharedPreferences
  // final bool isAppLock =
  //     PrefsService.getAppLockConfig() == 'true' ? true : false;

  final BehaviorSubject<bool> isSwitchFingerFtFaceIdOn =
      BehaviorSubject<bool>.seeded(
    PrefsService.getFaceIDConfig() == 'true' ? true : false,
  );
  final BehaviorSubject<String> textLockSetting =
      BehaviorSubject<String>.seeded(S.current.lock);
  final BehaviorSubject<bool> isSwitchAppLockOn = BehaviorSubject<bool>.seeded(
    PrefsService.getAppLockConfig() == 'true' ? true : false,
  );

  //stream
  Stream<bool> get isSwitchFingerFtFaceIdOnStream =>
      isSwitchFingerFtFaceIdOn.stream;

  Stream<bool> get isSwitchAppLockOnStream => isSwitchAppLockOn.stream;

  //sink
  Sink<bool> get isSwitchFingerFtFaceIdOnSink => isSwitchFingerFtFaceIdOn.sink;

  Sink<bool> get isSwitchAppLockOnSink => isSwitchAppLockOn.sink;

  void changeValueFingerFtFaceID({required bool value}) {
    isSwitchFingerFtFaceIdOnSink.add(value);
  }

  void changeValueAppLock({required bool value}) {
    isSwitchAppLockOnSink.add(value);
  }

  void isShowOrHideLockTxt(bool value) {
    if(value) {
      textLockSetting.sink.add(S.current.lock);
    } else {
      textLockSetting.sink.add('');
    }
  }

  //if user enable switch on app will or will not lock
  Future<void> setIsAppLock({required bool value}) async {
    if (value == true) {
      await PrefsService.saveAppLockConfig('true');
    } else {
      await PrefsService.saveAppLockConfig('false');
    }
  }

  Future<void> setFaceIdFtFingerLock({required bool value}) async {
    if (value == true) {
      await PrefsService.saveFaceIDConfig('true');
    } else {
      await PrefsService.saveFaceIDConfig('false');
    }
  }

  Future<void> setConfig({
    bool isAppLock = true,
    bool isFaceID = true,
  }) async {
    try {
      final data = {
        'isAppLock': isAppLock,
        'isFaceID': isFaceID,
      };
      await PrefsService.saveAppLockConfig(isAppLock.toString());
      await PrefsService.saveFaceIDConfig(isFaceID.toString());
      await trustWalletChannel.invokeMethod('setConfig', data);
    } on PlatformException {}
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'setConfigCallback':
        //todo
        isSuccess = await methodCall.arguments['isSuccess'];
        break;
      default:
        break;
    }
  }
}
