import 'package:Dfy/domain/model/pawn/detail_collateral.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_collateral_response.g.dart';

@JsonSerializable()
class DetailCollateralResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  DetailCollateralResponse(this.data);

  factory DetailCollateralResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailCollateralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailCollateralResponseToJson(this);

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
  double? reputation;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'completedContracts')
  double? completedContracts;
  @JsonKey(name: 'isActive')
  bool? isActive;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'nft')
  String? nft;
  @JsonKey(name: 'nftCollateralDetailDTO')
  String? nftCollateralDetailDTO;

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

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
    this.nft,
    this.nftCollateralDetailDTO,
  );

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  CollateralDetail toDomain() => CollateralDetail(
        id: id,
        type: type,
        userId: userId,
        reputation: reputation,
        numberOfferReceived: numberOfferReceived,
        loanSymbol: loanSymbol,
        loanAmount: loanAmount,
        loanAddress: loanAddress,
        latestBlockchainTxn: latestBlockchainTxn,
        isActive: isActive,
        expectedLoanAmount: expectedLoanAmount,
        expectedCollateralSymbol: expectedCollateralSymbol,
        estimatePrice: estimatePrice,
        durationType: durationType,
        durationQty: durationQty,
        completedContracts: completedContracts,
        collateralSymbol: collateralSymbol,
        collateralAmount: collateralAmount,
        collateralAddress: collateralAddress,
        bcCollateralId: bcCollateralId,
        description: description,
        walletAddress: walletAddress,
        status: status,
        nft: nft,
        nftCollateralDetailDTO: nftCollateralDetailDTO,
      );
}
