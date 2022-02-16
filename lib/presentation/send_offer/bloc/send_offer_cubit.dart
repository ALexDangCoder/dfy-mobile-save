import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/request/send_offer_request.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';
import 'package:Dfy/presentation/offer_detail/bloc/offer_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class SendOfferCubit extends BaseCubit<SendOfferState> {
  SendOfferCubit() : super(SendOfferInitial());

  final _btnSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;

  final _streamController = BehaviorSubject<int>.seeded(0);

  Stream<int> get streamIndex => _streamController.stream;

  Sink<int> get sinkIndex => _streamController.sink;

  final _web3utils = Web3Utils();

  NFTRepository get nftRepo => Get.find();
  void dispose() {
    _btnSubject.close();
    _streamController.close();
    close();
  }
  Future<String> getPawnHexString({
    required String nftCollateralId,
    required String repaymentAsset,
    required String loanAmount,
    required String interest,
    required String duration,
    required int loanDurationType,
    required int repaymentCycleType,
    required BuildContext context,
  }) async {
    showLoading();
    String hexString = await _web3utils.getCreateOfferData(
      nftCollateralId: nftCollateralId,
      repaymentAsset: repaymentAsset,
      loanAmount: loanAmount,
      interest: interest,
      duration: duration,
      loanDurationType: loanDurationType,
      repaymentCycleType: repaymentCycleType,
      context: context,
    );
    showContent();

    return hexString;
  }
  Future<void> sendOffer({
    required SendOfferRequest offerRequest,
  }) async {
   await nftRepo.sendOffer(offerRequest);
  }
}
