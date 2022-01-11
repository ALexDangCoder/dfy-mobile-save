import 'dart:convert';
import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../main.dart';
import 'approve_state.dart';

enum TYPE_CONFIRM_BASE {
  SEND_NFT,
  SEND_TOKEN,
  BUY_NFT,
  SEND_OFFER,
  PLACE_BID,
}

class ApproveCubit extends BaseCubit<ApproveState> {
  ApproveCubit() : super(ApproveInitState());
  late final NftMarket nftMarket;
  TYPE_CONFIRM_BASE type = TYPE_CONFIRM_BASE.BUY_NFT;

  List<Wallet> listWallet = [];
  String? nameWallet;
  double? gasLimit;
  String? addressWallet;
  double? balanceWallet;
  String? rawData;
  final Web3Utils web3Client = Web3Utils();
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

  Future<bool> sendRawData(String rawData) async {
    final result = await web3Client.sendRawTransaction(transaction: rawData);
    return result['isSuccess'];
  }

  Future<void> emitJsonNftToWalletCore({
    required String contract,
    int? id,
    required String address,
  }) async {
    final listNft = <Map<String, dynamic>>[];
    listNft.add({
      'id': '${nftMarket.nftTokenId}',
      'contract': '${nftMarket.collectionAddress}',
      'uri': nftMarket.image,
    });
    final result = {
      'name': nftMarket.name,
      'symbol': nftMarket.symbolToken,
      'contract': nftMarket.collectionAddress,
      'listNft': listNft,
    };
    await importNftIntoWalletCore(
      jsonNft: json.encode(result),
      address: address,
    );
  }

  Future<void> importNftIntoWalletCore({
    required String jsonNft,
    required String address,
  }) async {
    try {
      final data = {
        'jsonNft': jsonNft,
        'walletAddress': address,
      };
      await trustWalletChannel.invokeMethod('importNft', data);
    } on PlatformException {
      //todo
    }
  }

  ///
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
          addressWallet = listWallet.first.address;
          _nameWalletSubject.sink.add(listWallet.first.name!);
          nameWallet = listWallet.first.name;
          balanceWallet = await Web3Utils().getBalanceOfBnb(
              ofAddress: _addressWalletCoreSubject.valueOrNull ?? '');
          _balanceWalletSubject.sink.add(balanceWallet ?? 0);
        }
        showContent();
        break;
      case 'signTransactionWithDataCallback':
        rawData = methodCall.arguments['signedTransaction'];
        final result = await sendRawData(rawData ?? '');

        switch (type) {
          case TYPE_CONFIRM_BASE.BUY_NFT:
            if (result) {
              showContent();
              emit(BuySuccess());
            } else {
              emit(BuyFail());
            }
            break;
          default:
            break;
        }
        break;
        //todo
      case 'importNftCallback':
        final int code = await methodCall.arguments['code'];
        switch (code) {
          case 200:
            Fluttertoast.showToast(msg: 'Success');
            break;
          case 400:
            Fluttertoast.showToast(msg: 'Fail');
            break;
          case 401:
            Fluttertoast.showToast(msg: 'Fail');
            break;
        }
        break;
    }
  }

  Future<void> signTransactionWithData({
    required String walletAddress,
    required String contractAddress,
    required String nonce,
    required String chainId,
    required String gasPrice,
    required String gasLimit,
    required String hexString,
  }) async {
    try {
      showLoading();
      final data = {
        'walletAddress': walletAddress,
        'contractAddress': contractAddress,
        'nonce': nonce,
        'chainId': chainId,
        'gasPrice': gasPrice,
        'gasLimit': gasLimit,
        'withData': hexString,
      };
      await trustWalletChannel.invokeMethod('signTransactionWithData', data);
    } on PlatformException {}
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

  void changeLoadingState({required bool isShow}) {
    if (isShow) {
      showLoading();
    } else {
      showContent();
    }
  }

  Future<void> getGasPrice() async {
    final result = await Web3Utils().getGasPrice();
    gasPriceSubject.sink.add(double.parse(result));
  }

  void dispose() {
    gasPriceSubject.close();
    _addressWalletCoreSubject.close();
    _balanceWalletSubject.close();
    _nameWalletSubject.close();
  }
}
