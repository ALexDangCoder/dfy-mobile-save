import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';

part 'confirm_pw_prvkey_seedpharse_state.dart';

class ConfirmPwPrvKeySeedpharseCubit
    extends Cubit<ConfirmPwPrvKeySeedpharseState> {
  ConfirmPwPrvKeySeedpharseCubit() : super(ConfirmPwPrvKeySeedpharseInitial());
  bool isValidPW = false;
  bool isFaceID = false;
  String authorized = 'Not Authorized';
  bool authenticated = false;
  final LocalAuthentication auth = LocalAuthentication();

  final BehaviorSubject<bool> _isEnableButton =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _isSuccessWhenScan =
      BehaviorSubject<bool>.seeded(true);
  final BehaviorSubject<bool> _showValidatePW =
  BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<String> _txtWarningValidate =
  BehaviorSubject<String>.seeded('');
  final BehaviorSubject<bool> _showPW =
  BehaviorSubject<bool>.seeded(true);

  //stream
  Stream<bool> get isEnableBtnStream => _isEnableButton.stream;
  Stream<bool> get isSuccessWhenScanStream => _isSuccessWhenScan.stream;
  Stream<bool> get showPWStream => _showPW.stream;
  Stream<bool> get showValidatePWStream => _showValidatePW.stream;
  Stream<String> get txtWarningValidateStream => _txtWarningValidate.stream;

  //sink
  Sink<bool> get isEnableBtnSink => _isEnableButton.sink;
  Sink<bool> get isSuccessWhenScanSink => _isSuccessWhenScan.sink;
  Sink<bool> get showPWSink => _showPW.sink;
  Sink<bool> get showValidatePWSink => _showValidatePW.sink;
  Sink<String> get txtWarningValidateSink => _txtWarningValidate.sink;

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

  void checkValidate(String value, {required String rightPW}) {
    if(value != rightPW) {
      isValidPW = false;
      showValidatePWSink.add(true);
      txtWarningValidateSink.add(S.current.not_match);
    } else {
      isValidPW = true;
      showValidatePWSink.add(false);
    }
  }

  void showPW(int index) {
    if (index == 0) {
      showPWSink.add(true);
    } else {
      showPWSink.add(false);
    }
  }
}
