import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

class OfferDetailModel {
  num? id;
  num? userId;
  String? walletAddress;
  num? collateralId;
  num? bcCollateralId;
  num? point;
  num? status;
  String? description;
  num? offerId;
  String? supplyCurrencySymbol;
  num? loanAmount;
  num? estimate;
  String? repaymentToken;
  num? repaymentCycleType;
  String? repaymentAsset;
  String? latestBlockchainTxn;
  num? durationQty;
  int? durationType;
  num? interestRate;
  num? loanToValue;
  num? createdAt;
  num? bcOfferId;
  num? liquidationThreshold;
  StatusOffer statusOffer = StatusOffer.ACCEPTED;

  OfferDetailModel({
    this.id,
    this.userId,
    this.walletAddress,
    this.collateralId,
    this.bcCollateralId,
    this.point,
    this.status,
    this.description,
    this.offerId,
    this.supplyCurrencySymbol,
    this.loanAmount,
    this.estimate,
    this.repaymentToken,
    this.repaymentCycleType,
    this.latestBlockchainTxn,
    this.durationQty,
    this.durationType,
    this.interestRate,
    this.loanToValue,
    this.createdAt,
    this.bcOfferId,
    this.liquidationThreshold,
  });
}

class ColorText {
  String? status;
  Color? color;

  ColorText(this.status, this.color);

  ColorText.empty({this.status = '', this.color = Colors.white});
}
