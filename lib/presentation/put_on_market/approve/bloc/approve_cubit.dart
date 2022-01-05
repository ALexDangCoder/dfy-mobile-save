import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/presentation/put_on_market/approve/bloc/approve_state.dart';
import 'package:flutter/services.dart';

import '../../../../main.dart';

class ApproveCubit extends BaseCubit<ApproveState> {
  ApproveCubit() : super(ApproveInitState());

  void dispose(){

  }

  List<Wallet> listWallet = [];
  String? addressWalletCore;
  String? gnameWallet;
  double? balanceWallet;

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    print ("alo");
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
          // emit(NavigatorFirst());
          // await PrefsService.saveFirstAppConfig('true');
        } else {
          for (final element in data) {
            listWallet.add(Wallet.fromJson(element));
          }
          addressWalletCore = listWallet.first.address!;
          gnameWallet = listWallet.first.name!;
          balanceWallet = await Web3Utils()
              .getBalanceOfBnb(ofAddress: addressWalletCore ?? '');
        }
        break;
    }
  }

  Future<void> getListWallets() async {
    try {
      final data = {};
      await trustWalletChannel.invokeMethod('getListWallets', data);
    } on PlatformException {
      //nothing
    }
  }
  int randomAvatar() {
    final Random rd = Random();
    return rd.nextInt(10);
  }
}