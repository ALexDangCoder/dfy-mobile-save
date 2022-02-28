import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_mint_request_response.g.dart';

@JsonSerializable()
class ListMintRequestResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'rows')
  List<MintRequestResponse>? item;

  ListMintRequestResponse(
    this.rd,
    this.rc,
    this.item,
  );

  factory ListMintRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$ListMintRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListMintRequestResponseToJson(this);

  @override
  List<Object?> get props => [];

  List<MintRequestModel>? toDomain() => item?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class MintRequestResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'asset_type')
  AssetTypeResponse? assetType;
  @JsonKey(name: 'expecting_price')
  double? expectingPrice;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'expecting_price_symbol')
  String? expectingPriceSymbol;
  @JsonKey(name: 'create_at')
  int? createAt;

  MintRequestResponse(
    this.id,
    this.status,
    this.assetType,
    this.expectingPrice,
    this.name,
    this.expectingPriceSymbol,
    this.createAt,
  );

  factory MintRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$MintRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MintRequestResponseToJson(this);

  @override
  List<Object?> get props => [];

  MintRequestModel toDomain() => MintRequestModel(
        id: id,
        status: status,
        assetType: assetType?.toDomain(),
        expectingPrice: expectingPrice,
        name: name,
        expectingPriceSymbol: expectingPriceSymbol,
        createAt: createAt,
      );
}

@JsonSerializable()
class AssetTypeResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  AssetTypeResponse(this.id, this.name);

  factory AssetTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetTypeResponseToJson(this);

  AssetType toDomain() => AssetType(id, name);
}


