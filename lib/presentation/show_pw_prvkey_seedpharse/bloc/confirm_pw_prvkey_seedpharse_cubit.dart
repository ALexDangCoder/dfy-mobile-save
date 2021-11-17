import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';

part 'confirm_pw_prvkey_seedpharse_state.dart';

class ConfirmPwPrvKeySeedpharseCubit
    extends Cubit<ConfirmPwPrvKeySeedpharseState> {
  ConfirmPwPrvKeySeedpharseCubit() : super(ConfirmPwPrvKeySeedpharseInitial());

  bool isFaceID = false;
  String authorized = 'Not Authorized';
  bool authenticated = false;
  final LocalAuthentication auth = LocalAuthentication();

  final BehaviorSubject<bool> _isEnableButton =
      BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<bool> _isSuccessWhenScan =
      BehaviorSubject<bool>.seeded(false);

  //stream
  Stream<bool> get isEnableBtnStream => _isEnableButton.stream;
  Stream<bool> get isSuccessWhenScanStream => _isSuccessWhenScan.stream;

  //sink
  Sink<bool> get isEnableBtnSink => _isEnableButton.sink;
  Sink<bool> get isSuccessWhenScanSink => _isSuccessWhenScan.sink;

  void isEnableButton({required String value, String? passwordConfirm}) {
    if (value.isNotEmpty) {
      isEnableBtnSink.add(true);
    } else {
      isEnableBtnSink.add(false);
    }
  }

  Future<void> authenticate() async {
    isSuccessWhenScanSink.add(false);
    authenticated = await auth.authenticate(
      localizedReason:
          'Scan your fingerprint (or face or whatever) to authenticate',
      stickyAuth: true,
      biometricOnly: true,
    );
    if (authenticated == true) {
      isSuccessWhenScanSink.add(true);
    }
  }

  void getConfig() {
    if (PrefsService.getFaceIDConfig() == 'true') {
      isFaceID = true;
    } else {
      isFaceID = false;
    }
  }
}
