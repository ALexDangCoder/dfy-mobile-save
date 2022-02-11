import 'package:Dfy/domain/model/offer_detail.dart';
import 'package:json_annotation/json_annotation.dart';

part 'data_detail_offer_response.g.dart';

@JsonSerializable()
class DataOfferDetailResponse {
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'data')
  OfferDetailResponse? data;
  @JsonKey(name: 'trace_id')
  String? trace_id;

  DataOfferDetailResponse(this.error, this.data, this.trace_id);

  factory DataOfferDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$DataOfferDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataOfferDetailResponseToJson(this);
}

@JsonSerializable()
class OfferDetailResponse {
  @JsonKey(name: 'id')
  num? id;
  @JsonKey(name: 'userId')
  num? userId;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'collateralId')
  num? collateralId;
  @JsonKey(name: 'bcCollateralId')
  num? bcCollateralId;
  @JsonKey(name: 'point')
  num? point;
  @JsonKey(name: 'status')
  num? status;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'offerId')
  num? offerId;
  @JsonKey(name: 'supplyCurrencySymbol')
  String? supplyCurrencySymbol;
  @JsonKey(name: 'loanAmount')
  num? loanAmount;
  @JsonKey(name: 'estimate')
  num? estimate;
  @JsonKey(name: 'repaymentToken')
  String? repaymentToken;
  @JsonKey(name: 'repaymentCycleType')
  num? repaymentCycleType;
  @JsonKey(name: 'latestBlockchainTxn')
  String? latestBlockchainTxn;
  @JsonKey(name: 'durationQty')
  num? durationQty;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'interestRate')
  num? interestRate;
  @JsonKey(name: 'loanToValue')
  num? loanToValue;
  @JsonKey(name: 'createdAt')
  num? createdAt;
  @JsonKey(name: 'bcOfferId')
  num? bcOfferId;
  @JsonKey(name: 'liquidationThreshold')
  num? liquidationThreshold;

  OfferDetailResponse(
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
      this.liquidationThreshold);

  factory OfferDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailResponseToJson(this);

  OfferDetailModel toModel() => OfferDetailModel(
        id: id,
        walletAddress: walletAddress,
        collateralId: collateralId,
        bcCollateralId: bcCollateralId,
        description: description,
        createdAt: createdAt,
        interestRate: interestRate,
        durationType: durationType,
        durationQty: durationQty,
        repaymentToken: repaymentToken,
        loanAmount: loanAmount,
        status: status,
        supplyCurrencySymbol: supplyCurrencySymbol,
      );
}
