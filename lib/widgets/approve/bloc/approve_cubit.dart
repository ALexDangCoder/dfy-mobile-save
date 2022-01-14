import 'dart:convert';
import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/widgets/approve/bloc/approve_state.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

enum TYPE_CONFIRM_BASE {
  SEND_NFT,
  SEND_TOKEN,
  BUY_NFT,
  PUT_ON_MARKET,
  SEND_OFFER,
  PLACE_BID,
  CANCEL_SALE,
  CREATE_COLLECTION,
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

  ConfirmRepository get _confirmRepository => Get.find();
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

  Future<Map<String, dynamic>> sendRawData(String rawData) async {
    final result = await web3Client.sendRawTransaction(transaction: rawData);
    return result;
  }

  NFTRepository get _nftRepo => Get.find();

  Future<void> buyNftRequest(BuyNftRequest buyNftRequest) async {
    showLoading();
    final result = await _nftRepo.buyNftRequest(buyNftRequest);
    result.when(
      success: (res) {
        showContent();
      },
      error: (error) {
        showError();
      },
    );
  }

  Future<void> bidNftRequest(BidNftRequest bidNftRequest) async {
    showLoading();
    final result = await _nftRepo.bidNftRequest(bidNftRequest);
    result.when(
      success: (res) {
        showContent();
      },
      error: (error) {
        showError();
      },
    );
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
        } else {
          for (final element in data) {
            listWallet.add(Wallet.fromJson(element));
          }
          _addressWalletCoreSubject.sink.add(listWallet.first.address!);
          addressWallet = listWallet.first.address;
          _nameWalletSubject.sink.add(listWallet.first.name!);
          nameWallet = listWallet.first.name;
          try {
            balanceWallet = await Web3Utils().getBalanceOfBnb(
              ofAddress: _addressWalletCoreSubject.valueOrNull ?? '',
            );
            showContent();
          } catch (e) {
            showError();
            AppException('title', e.toString());
          }
          _balanceWalletSubject.sink.add(balanceWallet ?? 0);
        }
        break;
      case 'signTransactionWithDataCallback':
        rawData = methodCall.arguments['signedTransaction'];
        final result = await sendRawData(rawData ?? '');
        switch (type) {
          case TYPE_CONFIRM_BASE.BUY_NFT:
            if (result['isSuccess']) {
              showContent();
              emit(SignSuccess(result['txHash'], TYPE_CONFIRM_BASE.BUY_NFT));
            } else {
              showContent();
              emit(SignFail());
            }
            break;
          case TYPE_CONFIRM_BASE.CREATE_COLLECTION:
            if (result['isSuccess']) {
              showContent();
            } else {}
            break;
          case TYPE_CONFIRM_BASE.CANCEL_SALE:
            if (result['isSuccess']) {
              emit(SendRawDataSuccess(result['txHash']));
              showContent();
            } else {
              showError();
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
      showContent();
    } on PlatformException {
      //nothing
    }
  }

  int randomAvatar() {
    final Random rd = Random();
    return rd.nextInt(10);
  }

  Future<void> getGasPrice() async {
    try {
      final result = await Web3Utils().getGasPrice();
      gasPriceSubject.sink.add(double.parse(result));
    } catch (e) {
      showError();
      AppException('title', e.toString());
    }
  }

  Future<void> confirmCancelSaleWithBE(
      {required String txnHash, required String marketId}) async {
    final result = await _confirmRepository.getCancelSaleResponse(
      id: marketId,
      txnHash: txnHash,
    );
    result.when(success: (suc) {}, error: (err) {});
  }

  void dispose() {
    gasPriceSubject.close();
    _addressWalletCoreSubject.close();
    _balanceWalletSubject.close();
    _nameWalletSubject.close();
  }
}
