import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_signed_contract_response.g.dart';
@JsonSerializable()
class ListSignedContractUser extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  ListSignedContractUser(this.code, this.data);

  factory ListSignedContractUser.fromJson(Map<String, dynamic> json) =>
      _$ListSignedContractUserFromJson(json);

  Map<String, dynamic> toJson() => _$ListSignedContractUserToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContentResponse extends Equatable {
  @JsonKey(name: 'content')
  List<DataResponse>? data;

  ContentResponse(this.data);

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  List<SignedContractUser>? toDomain() => data?.map((e) => e.toDomain()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'collateral')
  String? collateralSymbol;
  @JsonKey(name: 'interest_per_year')
  num? interest;
  @JsonKey(name: 'collateral_amount')
  num? collateralAmount;
  @JsonKey(name: 'supply_currency')
  String? loanSymbol;
  @JsonKey(name: 'duration')
  int? durationQty;
  @JsonKey(name: 'duration_type')
  int? durationType;
  @JsonKey(name: 'nft')
  NftCollateralResponse? nftCollateral;

  DataResponse(
      this.id,
      this.collateralSymbol,
      this.interest,
      this.collateralAmount,
      this.loanSymbol,
      this.durationQty,
      this.durationType,
      this.nftCollateral,
      );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  SignedContractUser toDomain() => SignedContractUser(
    id: id,
    collateralSymbol: collateralSymbol,
    interestRate: interest,
    collateralAmount: collateralAmount,
    loanSymbol: loanSymbol,
    durationType: durationType,
    durationQty: durationQty,
    nftCollateral: nftCollateral?.toDomain(),
  );
}

@JsonSerializable()
class NftCollateralResponse {
  @JsonKey(name: 'nftId')
  String? nftId;
  @JsonKey(name: 'collectionAddress')
  String? collectionAddress;
  @JsonKey(name: 'bcNftId')
  int? nftTokenId;

  NftCollateralResponse(this.nftId, this.collectionAddress, this.nftTokenId);

  factory NftCollateralResponse.fromJson(Map<String, dynamic> json) =>
      _$NftCollateralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NftCollateralResponseToJson(this);

  NftCollateral toDomain() => NftCollateral(
    nftId: nftId,
    collectionAddress: collectionAddress,
    nftTokenId: nftTokenId,
  );
}
