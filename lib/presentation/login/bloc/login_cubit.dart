import 'package:Dfy/config/base/base_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';
  bool isAuthenticating = false;

  bool hidePass = true;

  bool hidePassword() {
    return hidePass = !hidePass;
  }


  Future<void> checkPass(String pass) async {}

  Future<void> authenticateWithBiometrics() async {
    emit(LoginLoading());
    bool authenticated = false;
    try {
      isAuthenticating = true;
      authenticated = await auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          stickyAuth: true,
          biometricOnly: true,);
    } on PlatformException catch (e) {
      isAuthenticating = false;
      _authorized = 'Error - ${e.message}';
      return;
    }
    if (authenticated == true) {
      emit(LoginSuccess());
    }
    else {
      emit(LoginError(_authorized));
    }
  }
}
