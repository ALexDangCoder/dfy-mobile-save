import 'dart:convert';
import 'dart:math';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/wallet.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:Dfy/widgets/approve/extension/get_gas_limit_extension.dart';
import 'package:flutter/material.dart';
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

  /// Name current wallet , after load screen success [nameWallet] have data
  /// when fail [nameWallet] is null
  /// [nameWallet] get in core
  String? nameWallet;

  /// address current wallet ,after load screen success [addressWallet] have data
  /// when fail [addressWallet] is null
  /// [addressWallet] get in core
  String? addressWallet;

  /// balance current wallet , after load screen success [balanceWallet] have data
  /// when fail [balanceWallet] is null
  /// [balanceWallet] get in web3
  double? balanceWallet;

  /// balance current wallet , after load screen success [gasPriceFirst] have data
  /// when fail [gasPriceFirst] is null
  /// this is min value of gas price
  /// [balanceWallet] get in web3
  double? gasPriceFirst;

  double? gasLimit;

  double? gasLimitFirst;

  double? gasPrice;

  String? rawData;

  String? hexString;

  ConfirmRepository get _confirmRepository => Get.find();

  bool needApprove = false;

  String? payValue;

  String? tokenAddress;

  bool checkingApprove = false;

  String? tokenApproveData;

  final Web3Utils web3Client = Web3Utils();
  final BehaviorSubject<String> _addressWalletCoreSubject =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _nameWalletSubject = BehaviorSubject<String>();
  final BehaviorSubject<double> _balanceWalletSubject =
      BehaviorSubject<double>();

  /// [gasPriceSubject] contain gas price init, not gas price final
  final BehaviorSubject<double> gasPriceFirstSubject =
      BehaviorSubject<double>();

  final BehaviorSubject<double> gasLimitFirstSubject =
  BehaviorSubject<double>();

  final BehaviorSubject<bool> canActionSubject = BehaviorSubject<bool>();

  final BehaviorSubject<bool> isApprovedSubject = BehaviorSubject<bool>();

  Stream<String> get addressWalletCoreStream =>
      _addressWalletCoreSubject.stream;

  Stream<String> get nameWalletStream => _nameWalletSubject.stream;

  Stream<bool> get isApprovedStream => isApprovedSubject.stream;

  Stream<double> get balanceWalletStream => _balanceWalletSubject.stream;

  Stream<bool> get canActionStream => canActionSubject.stream;

  Stream<double> get gasPriceFirstStream => gasPriceFirstSubject.stream;

  Stream<double> get gasLimitFirstStream => gasLimitFirstSubject.stream;

  Future<Map<String, dynamic>> sendRawData(String rawData) async {
    final result = await web3Client.sendRawTransaction(transaction: rawData);
    return result;
  }

  Future<bool> checkApprove({
    required String payValue,
    required String tokenAddress,
  }) async {
    showLoading();
    bool response = false;

    try {
      final result = await web3Client.isApproved(
        payValue: payValue,
        tokenAddress: tokenAddress,
        walletAddres: addressWallet ?? '',
        spenderAddress: getSpender(),
      );
      isApprovedSubject.sink.add(result);
      response = result;
    } on PlatformException {
      isApprovedSubject.sink.add(false);
      response = false;
    }
    showContent();
    return response;
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

  Future<void> gesGasLimitFirst(String hexString) async {
    showLoading();
    final gasLimitFirstResult =
        await getGasLimitByType(type: type, hexString: hexString);
    gasLimitFirst = gasLimitFirstResult;
    gasLimit = gasLimitFirstResult;
    gasLimitFirstSubject.sink.add(gasLimitFirstResult);
    gasPrice = gasPriceFirst;
    showContent();
  }

  Future<void> approve() async {
    final nonce =
        await web3Client.getTransactionCount(address: addressWallet ?? '');
    await signTransactionWithData(
      gasLimit: (gasLimit ?? 0).toInt().toString(),
      gasPrice: ((gasPrice ?? 0) / 1e9).toInt().toString(),
      chainId: Get.find<AppConstants>().chaninId,
      contractAddress: tokenAddress ?? '',
      walletAddress: addressWallet ?? '',
      nonce: nonce.count.toString(),
      hexString: tokenApproveData ?? '',
    );
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
          await getGasPrice();
          if (needApprove) {
            final result = await checkApprove(
              payValue: payValue ?? '',
              tokenAddress: tokenAddress ?? ' ',
            );
            if (result ){
              await gesGasLimitFirst(hexString ?? '');
            }
          }
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
        if (checkingApprove) {
          final resultApprove = await web3Client.sendRawTransaction(
            transaction: rawData ?? '',
          );
          checkingApprove = false;
          isApprovedSubject.sink.add(resultApprove.boolValue('isSuccess'));
        } else {
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
    } on PlatformException {
      //print ('â');
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

  String getSpender() {
    late String spender;
    switch (type) {
      case TYPE_CONFIRM_BASE.BUY_NFT:
        spender = nft_sales_address_dev2;
        break;
      case TYPE_CONFIRM_BASE.PLACE_BID:
        spender = nft_auction_dev2;
        break;
      default:
        spender = '';
        break;
    }
    return spender;
  }

  int randomAvatar() {
    final Random rd = Random();
    return rd.nextInt(10);
  }

  Future<void> getGasPrice() async {
    try {
      final result = await Web3Utils().getGasPrice();
      gasPriceFirstSubject.sink.add(double.parse(result));
      gasPriceFirst = double.parse(result);
      gasPrice = double.parse(result);
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
    gasPriceFirstSubject.close();
    _addressWalletCoreSubject.close();
    _balanceWalletSubject.close();
    _nameWalletSubject.close();
    isApprovedSubject.close();
  }
}
