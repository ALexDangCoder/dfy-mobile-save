import 'dart:async';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/presentation/offer_detail/bloc/offer_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SendOfferCubit extends BaseCubit<SendOfferState> {
  SendOfferCubit() : super(SendOfferInitial());

  final _btnSubject = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get btnStream => _btnSubject.stream;

  Sink<bool> get btnSink => _btnSubject.sink;
  String message = '';
  num loanAmount = 0;
  num interestRate = 0;
  num duration = 0;
  num typeDuration = 0;
  num repayment = 0;
  num repaymentString = 0;
  num recurringInterest = 0;

  final _streamController = BehaviorSubject<int>.seeded(0);

  Stream<int> get streamIndex => _streamController.stream;

  Sink<int> get sinkIndex => _streamController.sink;

  final _web3utils = Web3Utils();

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
}
