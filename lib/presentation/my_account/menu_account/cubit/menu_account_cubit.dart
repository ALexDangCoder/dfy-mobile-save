import 'dart:async';
import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

  LoginRepository get _loginRepository => Get.find();

  Future<void> logout() async {
    showLoading();
    await _loginRepository.logout();
    await PrefsService.clearWalletBE();
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
      final String wallet = PrefsService.getCurrentBEWallet();
      final Map<String, dynamic> mapProfileUser = jsonDecode(userInfo);
      addressWalletSubject.sink.add(wallet);
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
