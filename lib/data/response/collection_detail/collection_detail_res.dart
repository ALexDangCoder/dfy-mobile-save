import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_detail_res.g.dart';

@JsonSerializable()
class CollectionDetailRes extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'item')
  CollectionDetail? item;

  CollectionDetailRes(this.rd, this.rc, this.item);

  factory CollectionDetailRes.fromJson(Map<String, dynamic> json) =>
      _$CollectionDetailResFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionDetailResToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionDetail {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'owner')
  String? owner;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'feature_cid')
  String? featureCid;
  @JsonKey(name: 'txn_hash')
  String? txnHash;
  @JsonKey(name: 'owner_account')
  String? ownerAccount;
  @JsonKey(name: 'create_at')
  int? createAt;
  @JsonKey(name: 'update_at')
  int? updateAt;
  @JsonKey(name: 'total_nft')
  int? totalNft;
  @JsonKey(name: 'nft_owner_count')
  int? nftOwnerCount;
  @JsonKey(name: 'total_volume_traded')
  int? totalVolumeTraded;
  @JsonKey(name: 'collection_type')
  String? collectionType;
  @JsonKey(name: 'collection_standard')
  String? collectionStandard;
  @JsonKey(name: 'custom_url')
  String? customUrl;
  @JsonKey(name: 'royalty')
  double? royalty;
  @JsonKey(name: 'social_links')
  List<SocialLink>? socialLinks;
  @JsonKey(name: 'category_id')
  String? categoryId;
  @JsonKey(name: 'royalty_token')
  String? royaltyToken;
  @JsonKey(name: 'is_owner')
  bool? isOwner;
  @JsonKey(name: 'is_default')
  bool? isDefault;
  @JsonKey(name: 'is_white_list')
  bool? isWhiteList;

  CollectionDetail(
    this.id,
    this.name,
    this.description,
    this.owner,
    this.status,
    this.collectionAddress,
    this.avatarCid,
    this.coverCid,
    this.featureCid,
    this.txnHash,
    this.ownerAccount,
    this.createAt,
    this.updateAt,
    this.totalNft,
    this.nftOwnerCount,
    this.totalVolumeTraded,
    this.collectionType,
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

  factory CollectionDetail.fromJson(Map<String, dynamic> json) =>
      _$CollectionDetailFromJson(json);

  CollectionDetailModel toDomain() => CollectionDetailModel(
        totalVolumeTraded: totalVolumeTraded,
        nftOwnerCount: nftOwnerCount,
        coverCid: coverCid,
        avatarCid: avatarCid,
        totalNft: totalNft,
        description: description,
        name: name,
        id: id,
        categoryId: categoryId,
        collectionAddress: collectionAddress,
        collectionStandard: collectionStandard,
        collectionType: collectionType,
        createAt: createAt,
        customUrl: customUrl,
        featureCid: featureCid,
        isDefault: isDefault,
        isOwner: isOwner,
        isWhiteList: isWhiteList,
        owner: owner,
        ownerAccount: ownerAccount,
        royalty: royalty,
        royaltyToken: royaltyToken,
        socialLinks: socialLinks,
        status: status,
        txnHash: txnHash,
        updateAt: updateAt,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class SocialLink {
  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'url')
  String? url;

  SocialLink(this.type, this.url);

  factory SocialLink.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinkToJson(this);

  @override
  List<Object?> get props => [];
}
