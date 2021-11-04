import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/restore_account/bloc/string_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StringCubit extends Cubit<StringState> {
  StringCubit() : super(StringInitial('Seed phrase'));
  String select = 'Seed phrase';
  void selectSeed(String string) {
    emit(StringSelectSeed(string));
  }

  void selectPrivate(String string) {
    emit(StringSelectPrivate(string));
  }

  void showPopMenu() => emit(Show());

  void hidePopMenu() => emit(Hide());

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    String walletName = '';
    String walletAddress = '';

    switch (methodCall.method) {
      case 'importWalletCallback':
        walletName = methodCall.arguments['walletName'];
        walletAddress = methodCall.arguments['walletAddress'];
        break;

      default:
        break;
    }
  }

  Future<void> importWallet({
    required String type,
    required String content,
    String? password,
  }) async {
    try {
      final data = {
        'type': type,
        'content': content,
        'password': password,
      };
      await trustWalletChannel.invokeMethod('importWallet', data);
    } on PlatformException {}
  }
}
