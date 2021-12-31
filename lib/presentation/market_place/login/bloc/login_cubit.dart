import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../../main.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> getListWallet() async {
    try {
      await trustWalletChannel.invokeMethod('getListWallets');
    } on PlatformException {
      //nothing
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final  data = await methodCall.arguments['walletName'];
        print(data);
        // try {
        //   if (isSuccess) {
        //     emit(ChangePasswordSuccess());
        //   } else {
        //     emit(ChangePasswordFail());
        //   }
        // } catch (e) {
        //   print(e);
        // }
        break;
      default:
        break;
    }
  }

}
