import 'package:Dfy/data/response/create_hard_nft/detail_asset_hard_nft_response.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/collection_hard_nft.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_create_hard_nft.g.dart';

@JsonSerializable()
class CollectionCreateHardNftResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'rows')
  List<CollectionCreateHardNftItemResponse>? rows;

  CollectionCreateHardNftResponse(
    this.rd,
    this.rc,
    this.rows,
  );

  factory CollectionCreateHardNftResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionCreateHardNftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionCreateHardNftResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionCreateHardNftItemResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'is_whitelist')
  bool? isWhitelist;

  @JsonKey(name: 'collection_type')
  CollectionTypeResponse? collectionType;


  CollectionCreateHardNftItemResponse(this.id, this.name, this.avatarCid,
      this.collectionAddress, this.isWhitelist, this.collectionType);

  factory CollectionCreateHardNftItemResponse.fromJson(
          Map<String, dynamic> json) =>
      _$CollectionCreateHardNftItemResponseFromJson(json);

  CollectionHardNft toModel() => CollectionHardNft(
        name: name,
        id: id,
        avatarCid: avatarCid,
        collectionAddress: collectionAddress,
        collectionType: collectionType?.toDomain(),
      );

  Map<String, dynamic> toJson() =>
      _$CollectionCreateHardNftItemResponseToJson(this);

  @override
  List<Object?> get props => [];
}
