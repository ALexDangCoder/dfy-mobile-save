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

  final BehaviorSubject<String> addressWalletSubject = BehaviorSubject();

  Stream<String> get addressWalletStream => addressWalletSubject.stream;

  final BehaviorSubject<String> _emailSubject = BehaviorSubject();

  bool haveWalletInCore = false;

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
          haveWalletInCore = true;
        }
        showContent();
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
      final userInfo = PrefsService.getUserProfile();
      final Map<String, dynamic> mapProfileUser = jsonDecode(userInfo);
      if (mapProfileUser.stringValueOrEmpty('address') != '') {
        addressWalletSubject.sink.add(
          mapProfileUser.stringValueOrEmpty('address').handleString(),
        );
      }
      if (mapProfileUser.stringValueOrEmpty('email') != '') {
        _emailSubject.sink.add(mapProfileUser.stringValueOrEmpty('email'));
      }
      emit(LogonState());
    }
    getWallets();
  }

  int getIndexLogin() {
    return haveWalletInCore ? 2 : 3;
  }

  void initData() {
    getLoginState();
  }

  void dispose() {
    addressWalletSubject.close();
    _emailSubject.close();
  }
}
