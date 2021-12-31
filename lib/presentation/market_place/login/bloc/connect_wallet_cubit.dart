import 'package:Dfy/generated/l10n.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../../../main.dart';

part 'connect_wallet_state.dart';

class ConnectWalletCubit extends Cubit<ConnectWalletState> {
  ConnectWalletCubit() : super(ConnectWalletInitial());
  String contentDialog = '';
  String contentRightButton = '';
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
        try {
          if (data.isEmpty) {
            emit(HasNoWallet());
          } else if(data.isNotEmpty){
            emit(NeedLoginToUse());
          }else{
            print('Làm gì có chuyện ấy');
          }
        } catch (e) {
          print(e);
        }
        break;
      default:
        break;
    }
  }

}
