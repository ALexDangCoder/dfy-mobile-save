import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/request/put_on_market/put_on_auction_request.dart';
import 'package:Dfy/data/request/put_on_market/put_on_pawn_request.dart';
import 'package:Dfy/data/request/put_on_market/put_on_sale_request.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/env/model/app_constants.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_state.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class PutOnMarketCubit extends BaseCubit<PutOnMarketState> {
  PutOnMarketCubit() : super(PutOnMarketInitState());

  // common

  ConfirmRepository get confirmRepository => Get.find();

  late List<TokenInf> listToken;

  // tab sale

  TokenInf? tokenSale;
  double? valueTokenInputSale;
  int quantitySale = 1;

  final BehaviorSubject<bool> _canContinueSale = BehaviorSubject.seeded(false);

  Stream<bool> get canContinueSaleStream => _canContinueSale.stream;

  // tab pawn

  TokenInf? tokenPawn;
  double? valueTokenInputPawn;
  int? typeDuration;
  int? valueDuration;
  int quantityPawn = 1;
  bool validateDuration = false;

  TokenRepository get tokenRepository => Get.find();

  final BehaviorSubject<bool> _canContinuePawn = BehaviorSubject<bool>();

  Stream<bool> get canContinuePawnStream => _canContinuePawn.stream;

  // tab auction

  TokenInf? tokenAuction;
  double? valueTokenInputAuction;
  bool timeValidate = false;
  bool buyOutPriceValidate = true;
  bool priceStepValidate = true;

  final BehaviorSubject<bool> _canContinueAuction = BehaviorSubject<bool>();

  Stream<bool> get canContinueAuctionStream => _canContinueAuction.stream;

  // function sale
  void changeTokenSale({int? indexToken, double? value}) {
    if (indexToken != null) {
      tokenSale = listToken[indexToken];
    }
    if (value != null) {
      valueTokenInputSale = value;
    }
    updateStreamContinueSale();
  }

  void getListToken() {
    final String listTokenString = PrefsService.getListTokenSupport();
    listToken = TokenInf.decode(listTokenString);
  }

  Future<String> getHexStringPutOnSale(
    PutOnMarketModel putOnMarketModel,
    BuildContext context,
  ) async {
    showLoading();
    try {
      final data = await Web3Utils().getPutOnSalesSignData(
        tokenId: putOnMarketModel.nftTokenId ?? 0,
        context: context,
        currency: putOnMarketModel.tokenAddress ?? '',
        numberOfCopies: putOnMarketModel.numberOfCopies ?? 1,
        price: putOnMarketModel.price ?? '',
        collectionAddress: putOnMarketModel.collectionAddress ?? '',
      );
      showContent();
      return data;
    } catch (_) {
      showError();
      return '';
    }
  }

  void changeQuantitySale({required int value}) {
    quantitySale = value;
    updateStreamContinueSale();
  }

  void updateStreamContinueSale() {
    if (valueTokenInputSale != null &&
        valueTokenInputSale != 0 &&
        quantitySale > 0) {
      _canContinueSale.sink.add(true);
    } else {
      _canContinueSale.sink.add(false);
    }
  }

  // function pawn

  Future<String> getHexStringPutOnPawn(
    PutOnMarketModel putOnMarketModel,
    BuildContext context,
  ) async {
    showLoading();
    try {
      final data = await Web3Utils().getPutOnPawnData(
        durationType: putOnMarketModel.durationType ?? 0,
        nftTokenQuantity: (putOnMarketModel.numberOfCopies ?? '0').toString(),
        // so luong copy
        expectedDurationQty: putOnMarketModel.duration ?? '',
        //
        context: context,
        nftTokenId: (putOnMarketModel.nftTokenId ?? '0').toString(),
        beNFTId: putOnMarketModel.nftId ?? '',
        // id
        expectedlLoanAmount: putOnMarketModel.price ?? '',
        loanAsset: putOnMarketModel.tokenAddress ?? '',
        // token address
        nftContract:
            putOnMarketModel.collectionAddress ?? '', // nft collection address
      );
      showContent();
      return data;
    } catch (e) {
      showError();
      return '';
    }
  }

  void changeTokenPawn({int? indexToken, double? value}) {
    if (indexToken != null) {
      tokenPawn = listToken[indexToken];
    }
    if (value != null) {
      valueTokenInputPawn = value;
    }

    updateStreamContinuePawn();
  }

  void changeDurationPawn({int? type, int? value}) {
    if (type != null) {
      typeDuration = type;
    }
    if (value != null) {
      valueDuration = value;
    }
    updateStreamContinuePawn();
  }

  void changeQuantityPawn({required int value}) {
    quantityPawn = value;
    updateStreamContinuePawn();
  }

  void updateStreamContinuePawn() {
    if (valueTokenInputPawn != null &&
        valueTokenInputPawn != 0 &&
        valueDuration != 0 &&
        quantityPawn > 0 &&
        validateDuration) {
      _canContinuePawn.sink.add(true);
    } else {
      _canContinuePawn.sink.add(false);
    }
  }

  // auction function
  Future<String> getHexStringPutOnAuction(
    PutOnMarketModel putOnMarketModel,
    BuildContext context,
  ) async {
    showLoading();
    try {
      final data = await Web3Utils().getPutOnAuctionData(
        startingPrice: putOnMarketModel.price ?? '',
        startTime: putOnMarketModel.startTime ?? '',
        priceStep: (putOnMarketModel.priceStep == null ||
                putOnMarketModel.priceStep == '')
            ? putOnMarketModel.priceStep ?? '0'
            : '0',
        buyOutPrice: (putOnMarketModel.buyOutPrice == null ||
                putOnMarketModel.buyOutPrice == '')
            ? putOnMarketModel.buyOutPrice ?? '0'
            : '0',
        contractAddress: Get.find<AppConstants>().nftAuction,
        collectionAddress: putOnMarketModel.collectionAddress ?? '',
        currencyAddress: putOnMarketModel.tokenAddress ?? '',
        endTime: putOnMarketModel.endTime ?? '',
        context: context,
        tokenId: (putOnMarketModel.nftTokenId ?? 0).toString(),
      );
      showContent();
      return data;
    } catch (_) {
      showError();
      return '';
    }
  }

  void changeTokenAuction({int? indexToken, double? value}) {
    if (indexToken != null) {
      tokenAuction = listToken[indexToken];
    }
    if (value != null) {
      valueTokenInputAuction = value;
    }
    updateStreamContinueAuction();
  }

  void updateStreamContinueAuction() {
    if (valueTokenInputAuction != null &&
        valueTokenInputAuction != 0 &&
        timeValidate &&
        priceStepValidate &&
        buyOutPriceValidate) {
      _canContinueAuction.sink.add(true);
    } else {
      _canContinueAuction.sink.add(false);
    }
  }

  Future<bool> putOnAuction({
    required String txHash,
    required PutOnMarketModel putOnMarketModel,
  }) async {
    final bool haveBuyOutPrice = putOnMarketModel.buyOutPrice != null &&
        putOnMarketModel.buyOutPrice != '';
    final bool havePriceStep =
        putOnMarketModel.priceStep != null && putOnMarketModel.priceStep != '';
    final Map<String, dynamic> mapRawData = {
      'buy_out_price': double.parse(putOnMarketModel.buyOutPrice ?? '0'),
      'enable_buy_out_price': haveBuyOutPrice,
      'enable_price_step': havePriceStep,
      'end_time': int.parse(putOnMarketModel.endTime ?? '0'),
      'get_email': true,
      'nft_id': putOnMarketModel.nftId,
      'nft_type': putOnMarketModel.nftType ?? 0,
      'price_step': double.parse(putOnMarketModel.priceStep ?? '0'),
      'reserve_price': double.parse(putOnMarketModel.price ?? '0'),
      'start_time': int.parse(putOnMarketModel.startTime ?? '0'),
      'token': putOnMarketModel.tokenAddress,
      'txn_hash': txHash,
    };
    final PutOnAuctionRequest data = PutOnAuctionRequest.fromJson(mapRawData);
    final result = await confirmRepository.putOnAuction(data: data);
    bool res = false;
    result.when(
      success: (suc) {
        res = true;
      },
      error: (err) {
        res = false;
      },
    );
    return res;
  }

  Future<bool> putOnSale({
    required String txHash,
    required PutOnMarketModel putOnMarketModel,
  }) async {
    final Map<String, dynamic> mapRawData = {
      'nft_id': putOnMarketModel.nftId ?? '',
      'token': putOnMarketModel.tokenAddress ?? '',
      'txn_hash': txHash,
      'nft_type': putOnMarketModel.nftType ?? 0,
      'number_of_copies': putOnMarketModel.numberOfCopies ?? 1,
      'price': double.parse(putOnMarketModel.price ?? ''),
    };
    final PutOnSaleRequest data = PutOnSaleRequest.fromJson(mapRawData);
    final result = await confirmRepository.putOnSale(data: data);
    bool res = false;
    result.when(
      success: (suc) {
        res = true;
      },
      error: (err) {
        res = false;
      },
    );
    return res;
  }

  Future<bool> putOnPawn({
    required String txHash,
    required PutOnMarketModel putOnMarketModel,
  }) async {
    final userInfo = PrefsService.getUserProfile();
    final Map<String, dynamic> mapProfileUser = jsonDecode(userInfo);
    String userId = '';
    if (mapProfileUser.intValue('id') != 0) {
      userId = mapProfileUser.intValue('id').toString();
    }
    final Map<String, dynamic> mapRawData = {
      'beNftId': putOnMarketModel.nftId ?? '',
      'collectionAddress': putOnMarketModel.collectionAddress ?? '',
      'collectionIsWhitelist': putOnMarketModel.collectionIsWhitelist ?? false,
      'collectionName': putOnMarketModel.collectionName ?? '',
      'durationQuantity': putOnMarketModel.duration ?? '1',
      'durationType': putOnMarketModel.durationType ?? 0,
      'loanAmount': putOnMarketModel.price ?? '1',
      'loanSymbol': putOnMarketModel.loanSymbol ?? '1',
      'networkName': networkName,
      'nftMediaCid': putOnMarketModel.nftMediaCid ?? '1',
      'nftMediaType': putOnMarketModel.nftMediaType ?? '1',
      'nftName': putOnMarketModel.nftName ?? '1',
      'nftStandard': putOnMarketModel.nftStandard ?? 0,
      'nftType': (putOnMarketModel.nftType ?? 0).toString(),
      'numberOfCopies': putOnMarketModel.numberOfCopies ?? 0,
      'totalOfCopies': putOnMarketModel.totalOfCopies ?? 1,
      'txnHash': txHash,
      'userId': userId,
      // 'collectionId' : putOnMarketModelfsd,
      'id': putOnMarketModel.nftTokenId ?? 0,
      'walletAddress': PrefsService.getCurrentBEWallet(),
    };
    final PutOnPawnRequest data = PutOnPawnRequest.fromJson(mapRawData);
    final result = await confirmRepository.putOnPawn(data: data);
    bool res = false;
    result.when(
      success: (suc) {
        res = true;
      },
      error: (err) {
        res = false;
      },
    );
    return res;
  }

  void dispose() {
    _canContinuePawn.close();
    _canContinueSale.close();
  }
}
