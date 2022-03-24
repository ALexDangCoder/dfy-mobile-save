import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_crypto_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_sent_detail_crypto_response.g.dart';

@JsonSerializable()
class OfferSentDetailCryptoTotalResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  dynamic message;

  @JsonKey(name: 'data')
  OfferSentDetailCryptoResponse data;

  @JsonKey(name: 'trace_id')
  String? traceId;

  OfferSentDetailCryptoTotalResponse(
      this.error, this.code, this.message, this.data, this.traceId);

  factory OfferSentDetailCryptoTotalResponse.fromJson(
          Map<String, dynamic> json) =>
      _$OfferSentDetailCryptoTotalResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OfferSentDetailCryptoTotalResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class OfferSentDetailCryptoResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'userId')
  int? userId;

  @JsonKey(name: 'walletAddress')
  String? walletAddress;

  @JsonKey(name: 'collateralId')
  int? collateralId;

  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;

  @JsonKey(name: 'point')
  int? point;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'offerId')
  int? offerId;

  @JsonKey(name: 'supplyCurrencySymbol')
  String? supplyCurrencySymbol;

  @JsonKey(name: 'loanAmount')
  double? loanAmount;

  @JsonKey(name: 'estimate')
  double? estimate;

  @JsonKey(name: 'repaymentToken')
  String? repaymentToken;

  @JsonKey(name: 'repaymentCycleType')
  int? repaymentCycleType;

  @JsonKey(name: 'latestBlockchainTxn')
  String? latestBlockchainTxn;

  @JsonKey(name: 'durationQty')
  int? durationQty;

  @JsonKey(name: 'durationType')
  int? durationType;

  @JsonKey(name: 'interestRate')
  int? interestRate;

  @JsonKey(name: 'riskDefault')
  dynamic riskDefault;

  @JsonKey(name: 'systemRisk')
  dynamic systemRisk;

  @JsonKey(name: 'penaltyRate')
  dynamic penaltyRate;

  @JsonKey(name: 'loanToValue')
  double? loanToValue;

  @JsonKey(name: 'createdAt')
  int? createdAt;

  @JsonKey(name: 'bcOfferId')
  int? bcOfferId;

  @JsonKey(name: 'liquidationThreshold')
  int? liquidationThreshold;

  OfferSentDetailCryptoResponse(
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
    this.riskDefault,
    this.systemRisk,
    this.penaltyRate,
    this.loanToValue,
    this.createdAt,
    this.bcOfferId,
    this.liquidationThreshold,
  );

  OfferSentDetailCryptoModel toModel() => OfferSentDetailCryptoModel(
        status: status,
        walletAddress: walletAddress,
        userId: userId,
        liquidationThreshold: liquidationThreshold,
        interestRate: interestRate,
        bcOfferId: bcOfferId,
        id: id,
        durationType: durationType,
        durationQty: durationQty,
        bcCollateralId: bcCollateralId,
        description: description,
        latestBlockchainTxn: latestBlockchainTxn,
        collateralId: collateralId,
        createdAt: createdAt,
        estimate: estimate,
        loanAmount: loanAmount,
        loanToValue: loanToValue,
        offerId: offerId,
        point: point,
        repaymentCycleType: repaymentCycleType,
        repaymentToken: repaymentToken,
        supplyCurrencySymbol: supplyCurrencySymbol,
      );

  factory OfferSentDetailCryptoResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferSentDetailCryptoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferSentDetailCryptoResponseToJson(this);

  @override
  List<Object?> get props => [];
}
