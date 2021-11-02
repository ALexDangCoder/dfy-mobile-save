import 'package:Dfy/config/base/base_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends BaseCubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  bool hidePass = true;

  bool hidePassword() {
    return hidePass = !hidePass;
  }


  Future<void> checkPass(String pass) async {}

  String authorized = 'Not Authorized';
  bool authenticated = false;
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> authenticate() async {
    emit(LoginLoading());
    authenticated = await auth.authenticate(
      localizedReason:
      'Scan your fingerprint (or face or whatever) to authenticate',
      stickyAuth: true,
      biometricOnly: true,
    );
    if(authenticated == true) {
      emit(LoginSuccess());
    }
  }
}
