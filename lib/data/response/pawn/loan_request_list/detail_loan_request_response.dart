import 'package:Dfy/data/response/pawn/loan_request_list/loan_request_crypto_response.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/detail_loan_request_crypto_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_loan_request_response.g.dart';

@JsonSerializable()
class DetailLoanRequestTotalResponse extends Equatable {
  @JsonKey(name: 'data')
  DetailLoanRequestResponse data;

  DetailLoanRequestTotalResponse(this.data);

  factory DetailLoanRequestTotalResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailLoanRequestTotalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailLoanRequestTotalResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DetailLoanRequestResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'collateralSymbol')
  String? collateralSymbol;

  @JsonKey(name: 'loanSymbol')
  String? loanSymbol;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'status')
  int? status;

  @JsonKey(name: 'durationType')
  int? durationType;

  @JsonKey(name: 'durationQty')
  int? durationQty;

  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;

  @JsonKey(name: 'collateralId')
  int? collateralId;

  @JsonKey(name: 'collateralAmount')
  double? collateralAmount;

  @JsonKey(name: 'collateralOwner')
  CollateralOwnerResponse? collateralOwner;
  @JsonKey(name: 'pawnShopPackage')
  PawnShopLoanRQPackageResponse? pawnShopPackage;
  @JsonKey(name: 'p2pLenderPackage')
  P2PLenderPackageResponse? p2pLender;

  DetailLoanRequestResponse(
    this.id,
    this.collateralSymbol,
    this.loanSymbol,
    this.description,
    this.message,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.collateralId,
    this.collateralOwner,
    this.pawnShopPackage,
    this.p2pLender,
    this.collateralAmount,
  );

  DetailLoanRequestCryptoModel toModel() => DetailLoanRequestCryptoModel(
        id: id,
        description: description,
        status: status,
        p2pLenderPackageModel: p2pLender?.toModel(),
        message: message,
        collateralId: collateralId,
        bcCollateralId: bcCollateralId,
        durationQty: durationQty,
        durationType: durationType,
        loanSymbol: loanSymbol,
        collateralSymbol: collateralSymbol,
        collateralAmount: collateralAmount,
        packageLoanRqModel: pawnShopPackage?.toModel(),
        collateralOwnerLoanRqModel: collateralOwner?.toModel(),
      );

  factory DetailLoanRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailLoanRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailLoanRequestResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollateralOwnerResponse extends Equatable {
  @JsonKey(name: 'walletAddress')
  String? walletAddress;

  @JsonKey(name: 'reputationScore')
  int? reputationScore;

  CollateralOwnerResponse(this.walletAddress, this.reputationScore);

  CollateralOwnerLoanRqModel toModel() => CollateralOwnerLoanRqModel(
        walletAddress: walletAddress,
        reputationScore: reputationScore,
      );

  factory CollateralOwnerResponse.fromJson(Map<String, dynamic> json) =>
      _$CollateralOwnerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollateralOwnerResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class PawnShopLoanRQPackageResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'name')
  String? name;

  PawnShopLoanRQPackageResponse(this.id, this.type, this.name);

  PawnShopPackageLoanRqModel toModel() => PawnShopPackageLoanRqModel(
        type: type,
        id: id,
        name: name,
      );

  factory PawnShopLoanRQPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnShopLoanRQPackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PawnShopLoanRQPackageResponseToJson(this);

  @override
  List<Object?> get props => [];
}
