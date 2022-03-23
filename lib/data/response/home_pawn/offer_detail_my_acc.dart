import 'package:Dfy/domain/model/pawn/offer_detail_my_acc.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_detail_my_acc.g.dart';

@JsonSerializable()
class OfferDetailMyAccResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  OfferDetailMyAccResponse(this.data);

  factory OfferDetailMyAccResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferDetailMyAccResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailMyAccResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
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
  String? riskDefault;
  @JsonKey(name: 'systemRisk')
  String? systemRisk;
  @JsonKey(name: 'penaltyRate')
  double? penaltyRate;
  @JsonKey(name: 'loanToValue')
  double? loanToValue;
  @JsonKey(name: 'createdAt')
  int? createdAt;
  @JsonKey(name: 'bcOfferId')
  int? bcOfferId;
  @JsonKey(name: 'liquidationThreshold')
  int? liquidationThreshold;
  @JsonKey(name: 'description')
  String? description;

  DataResponse(
    this.id,
    this.userId,
    this.walletAddress,
    this.collateralId,
    this.bcCollateralId,
    this.point,
    this.status,
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
    this.description,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  OfferDetailMyAcc toDomain() => OfferDetailMyAcc(
        estimate: estimate,
        collateralId: collateralId,
        bcCollateralId: bcCollateralId,
        bcOfferId: bcOfferId,
        createdAt: createdAt,
        durationQty: durationQty,
        durationType: durationType,
        interestRate: interestRate,
        latestBlockchainTxn: latestBlockchainTxn,
        liquidationThreshold: liquidationThreshold,
        loanAmount: loanAmount,
        loanToValue: loanToValue,
        offerId: offerId,
        penaltyRate: penaltyRate,
        point: point,
        repaymentCycleType: repaymentCycleType,
        repaymentToken: repaymentToken,
        riskDefault: riskDefault,
        supplyCurrencySymbol: supplyCurrencySymbol,
        systemRisk: systemRisk,
        status: status,
        walletAddress: walletAddress,
        userId: userId,
        id: id,
        description: description,
      );
}
