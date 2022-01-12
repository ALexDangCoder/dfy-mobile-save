import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';
import 'approve_state.dart';


enum TYPE_CONFIRM_BASE {
  SEND_NFT,
  SEND_TOKEN,
  BUY_NFT,
  PUT_ON_MARKET,
  SEND_OFFER,
  PLACE_BID,
}

class ApproveCubit extends BaseCubit<ApproveState> {
  ApproveCubit() : super(ApproveInitState());

  List<Wallet> listWallet = [];
  String? nameWallet;
  double? gasLimit;
  String? addressWallet;
  double? balanceWallet;

  final BehaviorSubject<String> _addressWalletCoreSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _nameWalletSubject = BehaviorSubject<String>();
  final BehaviorSubject<double> _balanceWalletSubject =
      BehaviorSubject<double>();
  final BehaviorSubject<double> gasPriceSubject = BehaviorSubject<double>();

  Stream<String> get addressWalletCoreStream =>
      _addressWalletCoreSubject.stream;

  Stream<String> get nameWalletStream => _nameWalletSubject.stream;

  Stream<double> get balanceWalletStream => _balanceWalletSubject.stream;

  Stream<double> get gasPriceStream => gasPriceSubject.stream;


  ///
  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'getListWalletsCallback':
        final List<dynamic> data = methodCall.arguments;
        if (data.isEmpty) {
        } else {
          for (final element in data) {
            listWallet.add(Wallet.fromJson(element));
          }
          _addressWalletCoreSubject.sink.add(listWallet.first.address!);
          addressWallet = listWallet.first.address;
          _nameWalletSubject.sink.add(listWallet.first.name!);
          nameWallet = listWallet.first.name;
          try{
            balanceWallet = await Web3Utils().getBalanceOfBnb(
                ofAddress: _addressWalletCoreSubject.valueOrNull ?? '');
            showContent();
          } catch(e ){
            showError();
            AppException('title', e.toString());
          }
          _balanceWalletSubject.sink.add(balanceWallet?? 0);
        }
        break;
    }
  }

  Future<void> getListWallets() async {
    try {
      final data = {};
      showLoading();
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
    try{
      final result = await Web3Utils().getGasPrice();
      gasPriceSubject.sink.add(double.parse(result));
    } catch(e ){
      showError();
      AppException('title', e.toString());
    }
  }


  void dispose() {
    gasPriceSubject.close();
    _addressWalletCoreSubject.close();
    _balanceWalletSubject.close();
    _nameWalletSubject.close();

  }
}
