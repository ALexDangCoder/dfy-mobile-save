import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_out_request.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/place_bid/bloc/place_bid_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class PlaceBidCubit extends BaseCubit<PlaceBidState> {
  PlaceBidCubit() : super(PlaceBidInitial());
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

  NFTRepository get nftRepo => Get.find();

  void dispose() {
    _warnSubject.close();
    _btnSubject.close();
    _balanceSubject.close();
    close();
  }

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

  final Web3Utils web3Client = Web3Utils();

  Future<String> getBidData({
    required String contractAddress,
    required String auctionId,
    required String bidValue,
    required BuildContext context,
  }) async {
    showLoading();
    late final String hexString;
    try {
      hexString = await web3Client.getBidData(
        contractAddress: contractAddress,
        auctionId: auctionId,
        bidValue: bidValue,
        context: context,
      );
      showContent();
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
    return hexString;
  }

  Future<String> getBuyOutData({
    required String contractAddress,
    required String auctionId,
    required BuildContext context,
  }) async {
    showLoading();
    late final String hexString;
    try {
      hexString = await web3Client.getBuyOutData(
        contractAddress: contractAddress,
        auctionId: auctionId,
        context: context,
      );
      showContent();
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
    return hexString;
  }

  Future<void> bidRequest(BidNftRequest bidNftRequest) async {
    final result = await nftRepo.bidNftRequest(bidNftRequest);
    result.when(
      success: (res) {},
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          bidRequest(bidNftRequest);
        }
      },
    );
  }

  Future<void> buyRequest(BuyOutRequest buyOutRequest) async {
    final result = await nftRepo.buyOutRequest(buyOutRequest);
    result.when(
      success: (res) {},
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          buyRequest(buyOutRequest);
        }
      },
    );
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
}
