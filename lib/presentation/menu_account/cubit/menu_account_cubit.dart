import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';
import 'menu_account_state.dart';


class MenuAccountCubit extends BaseCubit<MenuAccountState> {
  MenuAccountCubit() : super(NoLoginState());

  final BehaviorSubject<String?> _addressWalletSubject =
      BehaviorSubject.seeded('seedValue');

  Stream<String?> get addressWalletStream => _addressWalletSubject.stream;

  Future<void> logout() async {
    showLoading();
    await Future.delayed(const Duration(seconds: 2));
    _addressWalletSubject.add(null);
    showContent();
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
        } else {
          for (final element in data) {
            final wallet = Wallet.fromJson(element);
            _addressWalletSubject.sink.add(wallet.address);
          }
        }
        break;
    }
  }

  Future<void> getWallets() async {
    try {
      final data = {};
      showLoading();
      await trustWalletChannel.invokeMethod('getListWallets', data);
      showContent();
    } on PlatformException {
      //nothing
    }
  }

  Future<void> getEmail () async{

  }

  void initData (){
    getWallets();
    getEmail();
  }

  void dispose (){
    _addressWalletSubject.close();
  }
}
