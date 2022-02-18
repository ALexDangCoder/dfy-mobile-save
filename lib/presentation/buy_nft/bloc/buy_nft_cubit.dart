import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../main.dart';

part 'buy_nft_state.dart';

class BuyNftCubit extends BaseCubit<BuyNftState> {
  BuyNftCubit() : super(BuyNftInitial()) {
    showLoading();
  }

  final _amountSubject = BehaviorSubject<int>();
  final Web3Utils web3Client = Web3Utils();
  double total = 0;

  Stream<int> get amountStream => _amountSubject.stream;

  Sink<int> get amountSink => _amountSubject.sink;

  int get amountValue => _amountSubject.valueOrNull ?? 1;
  final _warnSubject = BehaviorSubject<String>.seeded('');

  Stream<String> get warnStream => _warnSubject.stream;

  Sink<String> get warnSink => _warnSubject.sink;
  final _btnSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;
  final _balanceSubject = BehaviorSubject<double>.seeded(0);

  Stream<double> get balanceStream => _balanceSubject.stream;

  Sink<double> get balanceSink => _balanceSubject.sink;

  double get balanceValue => _balanceSubject.valueOrNull ?? 0;

  void dispose() {
    _balanceSubject.close();
    _btnSubject.close();
    _balanceSubject.close();
    _warnSubject.close();
    close();
  }

  NFTRepository get nftRepo => Get.find();

  Future<double> getBalanceToken({
    required String ofAddress,
    required String tokenAddress,
  }) async {
    showLoading();
    late final double balance;
    try {
      balance = await web3Client.getBalanceOfToken(
        ofAddress: ofAddress,
        tokenAddress: tokenAddress,
      );
      balanceSink.add(balance);
      showContent();
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
    return balance;
  }

  Future<String> getBuyNftData({
    required String contractAddress,
    required String orderId,
    required String numberOfCopies,
    required BuildContext context,
  }) async {
    late final String hexString;
    showLoading();
    try {
      hexString = await web3Client.getBuyNftData(
        contractAddress: contractAddress,
        orderId: orderId,
        numberOfCopies: numberOfCopies,
        context: context,
      );
      showContent();
    } catch (e) {
      showError();
      throw AppException(S.current.error, e.toString());
    }
    return hexString;
  }

  Future<void> importNft({
    required String contract,
    required String address,
    required int id,
  }) async {
    final res = await web3Client.importNFT(
      contract: contract,
      address: address,
      id: id,
    );
    if (res.isSuccess) {
      await emitJsonNftToWalletCore(
        contract: contract,
        address: address,
        id: id,
      );
    }
  }

  Future<void> emitJsonNftToWalletCore({
    required String contract,
    required int id,
    required String address,
  }) async {
    final result = await web3Client.getCollectionInfo(
        contract: contract, address: address, id: id);
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

  Future<dynamic> nativeMethodCallBackTrustWallet(MethodCall methodCall) async {
    switch (methodCall.method) {
      case 'importNftCallback':
        final int code = await methodCall.arguments['code'];
        switch (code) {
          case 200:
            await Fluttertoast.showToast(msg: S.current.nft_success);
            break;
          case 400:
            await Fluttertoast.showToast(msg: S.current.nft_fail);
            break;
          case 401:
            await Fluttertoast.showToast(msg: S.current.nft_fail);
            break;
        }
        break;
    }
  }

  Future<void> buyNftReq(BuyNftRequest buyNftRequest) async {
    final result = await nftRepo.buyNftRequest(buyNftRequest);
    result.when(
      success: (success) {},
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          buyNftReq(buyNftRequest);
        }
      },
    );
  }
}
