import 'dart:convert';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/abi/token.g.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/model/token_inf.dart';
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

  final BehaviorSubject<List<TokenInf>> _listTokenSubject =
      BehaviorSubject<List<TokenInf>>();

  Stream<List<TokenInf>> get listTokenStream => _listTokenSubject.stream;

  late List<TokenInf> listToken;

  // tab sale

  TokenInf? tokenSale;
  double? valueTokenInputSale;
  int quantitySale = 1;

  final BehaviorSubject<bool> _canContinueSale = BehaviorSubject.seeded(false);

  Stream<bool> get canContinueSaleStream => _canContinueSale.stream;

  // tab pawn

  TokenInf? tokenPawn;
  int? valueTokenInputPawn;
  int? typeDuration;
  int? valueDuration;
  int quantityPawn = 1;

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

  Future<void> getListToken() async {
    showLoading();
    final Result<List<TokenInf>> result = await tokenRepository.getListToken();
    result.when(
      success: (res) {
        listToken = res;
        _listTokenSubject.sink.add(res);
        showContent();
      },
      error: (error) {
        listToken = [];
        _listTokenSubject.sink.add([]);
        showError();
      },
    );
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
    if (valueTokenInputSale != null  && valueTokenInputSale != 0 && quantitySale > 0) {
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
        nftTokenQuantity: (putOnMarketModel.numberOfCopies ?? '0').toString(), // so luong copy
        expectedDurationQty:putOnMarketModel.duration ?? '', //
        context: context,
        nftTokenId: (putOnMarketModel.nftTokenId ?? '0').toString(),
        beNFTId: putOnMarketModel.nftId ??  '', // id
        expectedlLoanAmount: putOnMarketModel.price ?? '',
        loanAsset: putOnMarketModel.tokenAddress ?? '', // token address
        nftContract: putOnMarketModel.collectionAddress ??  '', // nft collection address
      );
      showContent();
      return data;
    } catch (e) {
      showError();
      return '';
    }
  }

  void changeTokenPawn({int? indexToken, int? value}) {
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
      valueTokenInputPawn = value;
    }
    typeDuration = type;
    valueDuration = value;
    updateStreamContinuePawn();
  }

  void changeQuantityPawn({required int value}) {
    quantityPawn = value;
    updateStreamContinuePawn();
  }

  void updateStreamContinuePawn() {
    if (valueTokenInputPawn != null
        && valueTokenInputPawn != 0
        && valueDuration != null &&
        quantityPawn > 0) {
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
        contractAddress: nft_sales_address_dev2,
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
    if (valueTokenInputAuction != null
        && valueTokenInputAuction != 0
        && timeValidate &&
        priceStepValidate &&
        buyOutPriceValidate) {
      _canContinueAuction.sink.add(true);
    } else {
      _canContinueAuction.sink.add(false);
    }
  }

  void dispose() {
    _canContinuePawn.close();
    _canContinueSale.close();
  }
}
