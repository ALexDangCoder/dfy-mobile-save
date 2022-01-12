import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_collection_res_market.g.dart';

@JsonSerializable()
class ListCollectionResponseMarket extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'rows')
  List<CollectionResponseMarket>? rows;

  ListCollectionResponseMarket(this.rd, this.rc, this.total, this.rows);

  factory ListCollectionResponseMarket.fromJson(Map<String, dynamic> json) =>
      _$ListCollectionResponseMarketFromJson(json);

  Map<String, dynamic> toJson() => _$ListCollectionResponseMarketToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionResponseMarket extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'total_nft')
  int? totalNft;
  @JsonKey(name: 'nft_owner_count')
  int? nftOwnerCount;
  @JsonKey(name: 'total_volume_traded')
  int? totalVolumeTraded;
  @JsonKey(name: 'is_feature')
  bool? isFeature;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;

  CollectionResponseMarket(
    this.id,
    this.name,
    this.description,
    this.type,
    this.avatarCid,
    this.coverCid,
    this.totalNft,
    this.nftOwnerCount,
    this.totalVolumeTraded,
    this.isFeature,
    this.collectionAddress,
  );

  factory CollectionResponseMarket.fromJson(Map<String, dynamic> json) =>
      _$CollectionResponseMarketFromJson(json);

  CollectionMarketModel toDomain() => CollectionMarketModel(
        id: id,
        name: name,
        description: description,
        type: type,
        totalNft: totalNft,
        avatarCid: avatarCid,
        coverCid: coverCid,
        isFeature: isFeature,
        nftOwnerCount: nftOwnerCount,
        totalVolumeTraded: totalVolumeTraded,
        addressCollection: collectionAddress,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
