import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_collateral_response.g.dart';

@JsonSerializable()
class ListCollateralResponse {
  @JsonKey(name: 'data')
  CollateralDataResponse? data;

  ListCollateralResponse(
    this.data,
  );

  factory ListCollateralResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCollateralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCollateralResponseToJson(this);
}

@JsonSerializable()
class CollateralDataResponse {
  @JsonKey(name: 'content')
  List<ContentResponse>? content;

  CollateralDataResponse(
    this.content,
  );

  factory CollateralDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CollateralDataResponseFromJson(json);
}

@JsonSerializable()
class ContentResponse {
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
  String? expectedLoanAmount;
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
  @JsonKey(name: 'nft')
  String? nft;
  @JsonKey(name: 'nftCollateralDetailDTO')
  String? nftCollateralDetailDTO;

  ContentResponse(
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

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  CollateralResultModel toDomain() => CollateralResultModel(
        status: status,
        walletAddress: walletAddress,
        type: type,
        description: description,
        id: id,
        bcCollateralId: bcCollateralId,
        collateralAddress: collateralAddress,
        collateralAmount: collateralAmount,
        collateralSymbol: collateralSymbol,
        completedContracts: completedContracts,
        durationQty: durationQty,
        durationType: durationType,
        estimatePrice: estimatePrice,
        expectedCollateralSymbol: expectedCollateralSymbol,
        expectedLoanAmount: expectedLoanAmount,
        isActive: isActive,
        latestBlockchainTxn: latestBlockchainTxn,
        loanAddress: loanAddress,
        loanAmount: loanAmount,
        loanSymbol: loanSymbol,
        numberOfferReceived: numberOfferReceived,
        reputation: reputation,
        userId: userId,
        nftCollateralDetailDTO: nftCollateralDetailDTO,
        nft: nft,
      );
}
