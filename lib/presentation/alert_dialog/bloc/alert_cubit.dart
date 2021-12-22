import 'dart:developer';

import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/alert_dialog/bloc/alert_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertCubit extends Cubit<AlertState> {
  AlertCubit() : super(AlertInitial());
  //todo remove
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    bool isSuccess = false;
    String type;
    switch (methodCall.method) {
      case 'earseAllWalletCallback':
        isSuccess = await methodCall.arguments['isSuccess'];
        log(isSuccess.toString());
        type = await methodCall.arguments['type'];
        if (isSuccess) {
          emit(EraseSuccess(type));
        } else {
          emit(EraseFail());
        }
        break;
      default:
        break;
    }
  }

  Future<void> earseAllWallet(String type) async {
    try {
      final data = {
        'type': type,
      };
      await trustWalletChannel.invokeMethod('earseAllWallet', data);
    } on PlatformException {}
  }
  void dispose(){
    super.close();
  }
}
