import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_collateral_response.g.dart';
@JsonSerializable()
class ListCollateralUser extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  ListCollateralUser(this.code, this.data);

  factory ListCollateralUser.fromJson(Map<String, dynamic> json) =>
      _$ListCollateralUserFromJson(json);

  Map<String, dynamic> toJson() => _$ListCollateralUserToJson(this);

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

  List<CollateralUser>? toDomain() => data?.map((e) => e.toDomain()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'collateralSymbol')
  String? collateralSymbol;
  @JsonKey(name: 'collateralAddress')
  String? collateralAddress;
  @JsonKey(name: 'collateralAmount')
  num? collateralAmount;
  @JsonKey(name: 'loanSymbol')
  String? loanSymbol;
  @JsonKey(name: 'durationQty')
  int? durationQty;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'totalAvailableCollaterals')
  NftCollateralResponse? nftCollateral;

  DataResponse(
    this.id,
    this.collateralSymbol,
    this.collateralAddress,
    this.collateralAmount,
    this.loanSymbol,
    this.durationQty,
    this.durationType,
    this.nftCollateral,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  CollateralUser toDomain() => CollateralUser(
    id: id,
    collateralSymbol: collateralSymbol,
    collateralAddress: collateralAddress,
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
