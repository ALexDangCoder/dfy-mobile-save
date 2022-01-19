import 'dart:async';
import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';
import 'menu_account_state.dart';

class MenuAccountCubit extends BaseCubit<MenuAccountState> {
  MenuAccountCubit() : super(NoLoginState());

  final BehaviorSubject<String> _addressWalletSubject =
      BehaviorSubject();
  Stream<String> get addressWalletStream => _addressWalletSubject.stream;

  final BehaviorSubject<String> _emailSubject =
  BehaviorSubject();

  Stream<String> get emailStream => _emailSubject.stream;

  Future<void> logout() async {
    showLoading();
    await PrefsService.clearWalletLogin();
    showContent();
    emit(NoLoginState());
  }

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isNotEmpty) {
          for (final element in data) {
            final wallet = Wallet.fromJson(element);
            if ((wallet.address?.length ?? 0) > 18){
              _addressWalletSubject.sink.add(wallet.address!.handleString());
            }
            else {
              _addressWalletSubject.sink.add(wallet.address ?? '');
            }
            if (state is LogonState){
              await getEmail();
            }else{
              showContent();
            }
          }
        }
        break;
    }
  }

  Future<void> getWallets() async {
    try {
      showLoading();
      await trustWalletChannel.invokeMethod('getListWallets', {});
    } on PlatformException {
      //nothing
    }
  }

  void getLoginState() {
    final account = PrefsService.getWalletLogin();
    final Map<String, dynamic> mapLoginState = jsonDecode(account);
    if (mapLoginState.stringValueOrEmpty('accessToken') != '') {
      emit(LogonState());
    }
    getWallets();
  }

  int  getIndexLogin (){
    if (_addressWalletSubject.valueOrNull  == null) {
      return 3;
    }else {
      return 2;
    }
  }

  Future<void> getEmail() async {
    Future.delayed(Duration(seconds: 2), (){
      _emailSubject.sink.add('edsolabs@edsolabs.com');
      showContent();
    });
  }

  void initData() {
    getLoginState();
  }

  void dispose() {
    _addressWalletSubject.close();
    _emailSubject.close();
  }
}
