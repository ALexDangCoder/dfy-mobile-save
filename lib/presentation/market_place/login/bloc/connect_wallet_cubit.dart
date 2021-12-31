import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../../main.dart';

part 'connect_wallet_state.dart';

class ConnectWalletCubit extends Cubit<ConnectWalletState> {
  ConnectWalletCubit() : super(ConnectWalletInitial());

  Future<void> getListWallet() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getListWallets',data);
    } on PlatformException catch (e){
      //nothing
      throw e;
    }
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = await methodCall.arguments;
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
