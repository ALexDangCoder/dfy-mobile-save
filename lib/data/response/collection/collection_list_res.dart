import 'package:Dfy/data/request/collection/social_link_map_request.dart';
import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_list_res.g.dart';

@JsonSerializable()
class CollectionListRes extends Equatable {
  @JsonKey(name: 'rd')
  final String? rd;

  @JsonKey(name: 'rc')
  final int? rc;

  @JsonKey(name: 'total')
  final int? total;

  @JsonKey(name: 'rows')
  final List<CollectionResponse>? rows;

  const CollectionListRes(
    this.rd,
    this.rc,
    this.total,
    this.rows,
  );

  factory CollectionListRes.fromJson(Map<String, dynamic> json) =>
      _$CollectionListResFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionListResToJson(this);

  @override
  List<Object?> get props => [];

}

@JsonSerializable()
class CollectionResponse extends Equatable {
  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'owner')
  final String? owner;
  @JsonKey(name: 'status')
  final int? status;
  @JsonKey(name: 'collection_address')
  final String? collectionAddress;
  @JsonKey(name: 'avatar_cid')
  final String? avatarCid;
  @JsonKey(name: 'cover_cid')
  final String? coverCid;
  @JsonKey(name: 'feature_cid')
  final String? featureCid;
  @JsonKey(name: 'txn_hash')
  final String? txnHash;
  @JsonKey(name: 'owner_account')
  final String? ownerAccount;
  @JsonKey(name: 'create_at')
  final int? createAt;
  @JsonKey(name: 'update_at')
  final int? updateAt;
  @JsonKey(name: 'total_nft')
  final int? totalNft;
  @JsonKey(name: 'nft_owner_count')
  final int? nftOwnerCount;
  @JsonKey(name: 'total_volume_traded')
  final int? totalVolumeTraded;
  @JsonKey(name: 'collection_type')
  final String? collectionType;
  @JsonKey(name: 'collection_standard')
  final String? collectionStandard;
  @JsonKey(name: 'custom_url')
  final String? customUrl;
  @JsonKey(name: 'royalty')
  final double? royalty;
  @JsonKey(name: 'social_links')
  final List<SocialLinkMapRequest>? socialLinks;
  @JsonKey(name: 'category_id')
  final String? categoryId;
  @JsonKey(name: 'royalty_token')
  final String? royaltyToken;
  @JsonKey(name: 'is_owner')
  final bool? isOwner;
  @JsonKey(name: 'is_default')
  final bool? isDefault;
  @JsonKey(name: 'is_white_list')
  final bool? isWhiteList;

  CollectionResponse(
    this.avatarCid,
    this.name,
    this.id,
    this.collectionAddress,
    this.collectionType,
    this.description,
    this.owner,
    this.status,
    this.coverCid,
    this.featureCid,
    this.txnHash,
    this.ownerAccount,
    this.createAt,
    this.updateAt,
    this.totalNft,
    this.nftOwnerCount,
    this.totalVolumeTraded,
    this.collectionStandard,
    this.customUrl,
    this.royalty,
    this.socialLinks,
    this.categoryId,
    this.royaltyToken,
    this.isOwner,
    this.isDefault,
    this.isWhiteList,
  );

  factory CollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionResponseFromJson(json);

  CollectionMarketModel toDomain() => CollectionMarketModel(
        avatarCid: avatarCid,
        name: name,
        collectionId: id,
        addressCollection: collectionAddress,
        type: collectionType?.parseToInt() ?? -1,
      );

  @override
  List<Object?> get props => [];
}
