import 'package:Dfy/domain/model/home_pawn/collateral_detail_my_acc_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collateral_detail_my_acc_response.g.dart';

@JsonSerializable()
class CollateralDetailMyAccResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  CollateralDetailMyAccResponse(this.data);

  factory CollateralDetailMyAccResponse.fromJson(Map<String, dynamic> json) =>
      _$CollateralDetailMyAccResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollateralDetailMyAccResponseToJson(this);

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
  @JsonKey(name: 'collateralSymbol')
  String? collateralSymbol;
  @JsonKey(name: 'collateralAddress')
  String? collateralAddress;
  @JsonKey(name: 'collateralAmount')
  double? collateralAmount;
  @JsonKey(name: 'loanSymbol')
  String? loanSymbol;
  @JsonKey(name: 'loanAmount')
  double? loanAmount;
  @JsonKey(name: 'loanAddress')
  String? loanAddress;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'durationQty')
  int? durationQty;
  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;
  @JsonKey(name: 'numberOfferReceived')
  int? numberOfferReceived;
  @JsonKey(name: 'latestBlockchainTxn')
  String? latestBlockchainTxn;
  @JsonKey(name: 'estimatePrice')
  double? estimatePrice;
  @JsonKey(name: 'expectedLoanAmount')
  double? expectedLoanAmount;
  @JsonKey(name: 'expectedCollateralSymbol')
  String? expectedCollateralSymbol;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'completedContracts')
  int? completedContracts;
  @JsonKey(name: 'isActive')
  bool? isActive;
  @JsonKey(name: 'type')
  int? type;

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  DataResponse(
    this.id,
    this.userId,
    this.collateralSymbol,
    this.collateralAddress,
    this.collateralAmount,
    this.loanSymbol,
    this.loanAmount,
    this.loanAddress,
    this.description,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.numberOfferReceived,
    this.latestBlockchainTxn,
    this.estimatePrice,
    this.expectedLoanAmount,
    this.expectedCollateralSymbol,
    this.reputation,
    this.walletAddress,
    this.completedContracts,
    this.isActive,
    this.type,
  );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  CollateralDetailMyAcc toDomain() => CollateralDetailMyAcc(
        id: id,
        status: status,
        type: type,
        reputation: reputation,
        bcCollateralId: bcCollateralId,
        durationType: durationType,
        walletAddress: walletAddress,
        description: description,
        userId: userId,
        collateralAddress: collateralAddress,
        loanAmount: loanAmount,
        latestBlockchainTxn: latestBlockchainTxn,
        durationQty: durationQty,
        collateralAmount: collateralAmount,
        collateralSymbol: collateralSymbol,
        completedContracts: completedContracts,
        estimatePrice: estimatePrice,
        expectedCollateralSymbol: expectedCollateralSymbol,
        expectedLoanAmount: expectedLoanAmount,
        isActive: isActive,
        loanAddress: loanAddress,
        loanSymbol: loanSymbol,
        numberOfferReceived: numberOfferReceived,
      );
}
