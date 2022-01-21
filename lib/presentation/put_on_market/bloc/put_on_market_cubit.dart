import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/abi/token.g.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:Dfy/presentation/put_on_market/bloc/put_on_market_state.dart';
import 'package:Dfy/presentation/put_on_market/model/nft_put_on_market_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

enum DurationType { MONTH, WEEK }

class PutOnMarketCubit extends BaseCubit<PutOnMarketState> {
  PutOnMarketCubit() : super(PutOnMarketInitState());
  // common


  final BehaviorSubject<List<TokenInf>> _listTokenSubject = BehaviorSubject<List<TokenInf>>();

  Stream<List<TokenInf>> get listTokenStream => _listTokenSubject.stream;

  List<TokenInf>? listToken ;
  // tab sale

  TokenInf? tokenSale;
  double? valueTokenInputSale;
  int quantitySale = 1;

  final BehaviorSubject<bool> _canContinueSale = BehaviorSubject<bool>();

  Stream<bool> get canContinueSaleStream => _canContinueSale.stream;





  // tab pawn

  TokenInf? tokenPawn;
  double? valueTokenInputPawn;
  DurationType? typeDuration;
  int? valueDuration;
  int quantityPawn = 1;


  TokenRepository get tokenRepository => Get.find();

  final BehaviorSubject<bool> _canContinuePawn = BehaviorSubject<bool>();

  Stream<bool> get canContinuePawnStream => _canContinuePawn.stream;

  // tab auction

  TokenInf? tokenAuction;
  double? valueTokenInputAuction;

  // function sale
  void changeTokenSale({int? indexToken, double? value}) {
    tokenSale = listToken?[indexToken ?? 0];
    valueTokenInputSale = value;
    updateStreamContinueSale();
  }



  Future<void> getListToken ()async {
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
    if (valueTokenInputSale != null && quantitySale > 0) {
      _canContinueSale.sink.add(true);
    } else {
      _canContinueSale.sink.add(false);
    }
  }

  // function pawn
  void changeTokenPawn({int? indexToken, double? value}) {
    tokenPawn = listToken?[indexToken ?? 0];
    valueTokenInputPawn = value;

    updateStreamContinuePawn();
  }

  void changeDurationPawn({DurationType? type, int? value}) {
    typeDuration = type;
    valueDuration = value;
    updateStreamContinuePawn();
  }

  void changeQuantityPawn({required int value}) {
    quantityPawn = value;
    updateStreamContinuePawn();
  }

  void updateStreamContinuePawn() {
    if (valueTokenInputPawn != null &&
        valueDuration != null &&
        quantityPawn > 0) {
      _canContinuePawn.sink.add(true);
    } else {
      _canContinuePawn.sink.add(false);
    }
  }

  void dispose() {
    _canContinuePawn.close();
    _canContinueSale.close();
  }
}
