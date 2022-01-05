import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/presentation/put_on_market/approve/bloc/approve_state.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';

class ApproveCubit extends BaseCubit<ApproveState> {
  ApproveCubit() : super(ApproveInitState());

  List<Wallet> listWallet = [];
  double? gasPrice;

  final BehaviorSubject<String> _addressWalletCoreSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _nameWalletSubject = BehaviorSubject<String>();
  final BehaviorSubject<double> _balanceWalletSubject =
      BehaviorSubject<double>();

  Stream<String> get addressWalletCoreStream =>
      _addressWalletCoreSubject.stream;

  Stream<String> get nameWalletStream => _nameWalletSubject.stream;

  Stream<double> get balanceWalletStream => _balanceWalletSubject.stream;

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
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
          _addressWalletCoreSubject.sink.add(listWallet.first.address!);
          _nameWalletSubject.sink.add(listWallet.first.name!);
          final double balanceWallet = await Web3Utils().getBalanceOfBnb(
              ofAddress: _addressWalletCoreSubject.valueOrNull ?? '');
          _balanceWalletSubject.sink.add(balanceWallet);
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

  Future<void> getGasPrice() async {
    final result = await Web3Utils().getGasPrice();
    gasPrice = double.parse(result);
  }


  void dispose() {}
}
