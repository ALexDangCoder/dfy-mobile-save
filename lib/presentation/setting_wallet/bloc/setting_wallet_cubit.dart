import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'setting_wallet_state.dart';

class SettingWalletCubit extends Cubit<SettingWalletState> {
  SettingWalletCubit() : super(SettingWalletInitial());

  //this variable is current value of AppLock get from SharedPreferences
  // final bool isAppLock =
  //     PrefsService.getAppLockConfig() == 'true' ? true : false;

  final BehaviorSubject<bool> _isSwitchFingerFtFaceIdOn =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isSwitchAppLockOn = BehaviorSubject<bool>.seeded(
      PrefsService.getAppLockConfig() == 'true' ? true : false,);

  //stream
  Stream<bool> get isSwitchFingerFtFaceIdOnStream =>
      _isSwitchFingerFtFaceIdOn.stream;

  Stream<bool> get isSwitchAppLockOnStream => _isSwitchAppLockOn.stream;

  //sink
  Sink<bool> get isSwitchFingerFtFaceIdOnSink => _isSwitchFingerFtFaceIdOn.sink;

  Sink<bool> get isSwitchAppLockOnSink => _isSwitchAppLockOn.sink;

  void changeValueFingerFtFaceID({required bool value}) {
    isSwitchFingerFtFaceIdOnSink.add(value);
  }

  void changeValueAppLock({required bool value}) {
    isSwitchAppLockOnSink.add(value);
  }

  //if user enable switch on app will or will not lock
  Future<void> setIsAppLock({required bool value}) async {
    if (value == true) {
      await PrefsService.saveAppLockConfig('true');
    } else {
      await PrefsService.saveAppLockConfig('false');
    }
  }
}
