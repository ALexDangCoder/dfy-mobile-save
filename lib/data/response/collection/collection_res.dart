import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_res.g.dart';

@JsonSerializable()
class ListCollectionResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'rows')
  List<CollectionResponse>? rows;

  ListCollectionResponse(
    this.rd,
    this.rc,
    this.total,
    this.rows,
    this.traceId,
  );

  factory ListCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCollectionResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'txn_hash')
  String? txnHash;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'collection_name')
  String? collectionName;
  @JsonKey(name: 'number_of_item')
  int? numberOfItem;
  @JsonKey(name: 'number_of_owner')
  int? numberOfOwner;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'nft_type')
  int? nftType;
  @JsonKey(name: 'collection_id')
  String? collectionId;
  @JsonKey(name: 'be_id')
  String? beId;
  @JsonKey(name: 'standard')
  int? standard;
  @JsonKey(name: 'custom_url')
  String? customUrl;
  @JsonKey(name: 'feature_cid')
  String? featureCid;
  @JsonKey(name: 'is_whitelist')
  bool? isWhitelist;

  CollectionResponse(
    this.id,
    this.txnHash,
    this.coverCid,
    this.avatarCid,
    this.collectionName,
    this.numberOfItem,
    this.numberOfOwner,
    this.walletAddress,
    this.collectionAddress,
    this.description,
    this.nftType,
    this.collectionId,
    this.beId,
    this.standard,
    this.customUrl,
    this.featureCid,
    this.isWhitelist,
  );

  factory CollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionResponseFromJson(json);

  CollectionMarketModel toDomain() => CollectionMarketModel(
        id: id,
        name: collectionName,
        description: description,
        type: nftType,
        totalNft: numberOfItem,
        avatarCid: avatarCid,
        coverCid: coverCid,
        nftOwnerCount: numberOfOwner,
        addressCollection: collectionAddress,
        collectionId: collectionId,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
