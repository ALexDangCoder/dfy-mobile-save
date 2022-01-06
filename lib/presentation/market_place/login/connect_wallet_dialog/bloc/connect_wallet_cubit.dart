import 'package:Dfy/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../../../main.dart';


part 'connect_wallet_state.dart';

class ConnectWalletCubit extends Cubit<ConnectWalletState> {
  ConnectWalletCubit() : super(ConnectWalletInitial());
  String contentDialog = '';
  String contentRightButton = '';
  Future<void> getListWallet() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getConfig',data);
    } on PlatformException catch (e){
      //nothing
      throw e;
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
