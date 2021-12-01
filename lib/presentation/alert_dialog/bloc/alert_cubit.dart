import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/alert_dialog/bloc/alert_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertCubit extends Cubit<AlertState> {
  AlertCubit() : super(AlertInitial());

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    bool isSuccess = false;
    String type;
    switch (methodCall.method) {
      case 'earseWalletCallback':
        isSuccess = await methodCall.arguments['isSuccess'];
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

  Future<void> earseWallet(String type) async {
    try {
      final data = {
        'type': type,
      };
      await trustWalletChannel.invokeMethod('earseWallet', data);
    } on PlatformException {}
  }
}
