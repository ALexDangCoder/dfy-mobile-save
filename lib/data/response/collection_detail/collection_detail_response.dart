import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_detail_response.g.dart';

@JsonSerializable()
class CollectionDetailResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'item')
  CollectionDetail? item;

  CollectionDetailResponse(
    this.rd,
    this.rc,
    this.item,
    this.traceId,
  );

  factory CollectionDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionDetailResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionDetail {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'owner')
  String? owner;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'collection_type')
  int? collectionType;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'feature_cid')
  String? featureCid;
  @JsonKey(name: 'total_nft')
  int? totalNft;
  @JsonKey(name: 'nft_owner_count')
  int? nftOwnerCount;
  @JsonKey(name: 'total_volume_traded')
  int? totalVolumeTraded;
  @JsonKey(name: 'collection_standard')
  int? collectionStandard;
  @JsonKey(name: 'social_links')
  List<SocialLink>? socialLinks;
  @JsonKey(name: 'is_owner')
  bool? isOwner;
  @JsonKey(name: 'is_default')
  bool? isDefault;
  @JsonKey(name: 'is_white_list')
  bool? isWhiteList;
  @JsonKey(name: 'be_id')
  String? beId;

  CollectionDetail(
    this.id,
    this.name,
    this.owner,
    this.description,
    this.status,
    this.category,
    this.collectionType,
    this.collectionAddress,
    this.avatarCid,
    this.coverCid,
    this.featureCid,
    this.totalNft,
    this.nftOwnerCount,
    this.totalVolumeTraded,
    this.collectionStandard,
    this.socialLinks,
    this.isOwner,
    this.isDefault,
    this.isWhiteList,
    this.beId,
  );

  factory CollectionDetail.fromJson(Map<String, dynamic> json) =>
      _$CollectionDetailFromJson(json);

  CollectionDetailModel toDomain() => CollectionDetailModel(
        id: id,
        name: name,
        collectionAddress: collectionAddress,
        status: status,
        socialLinks: socialLinks?.map((e) => e.toDomain()).toList(),
        owner: owner,
        isWhiteList: isWhiteList,
        isOwner: isOwner,
        isDefault: isDefault,
        featureCid: featureCid,
        collectionType: collectionType,
        description: description,
        totalNft: totalNft,
        avatarCid: avatarCid,
        coverCid: coverCid,
        nftOwnerCount: nftOwnerCount,
        totalVolumeTraded: totalVolumeTraded,
        beId: beId,
        collectionStandard: collectionStandard,
        categoryType: category,
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

  SocialLinkModel toDomain() => SocialLinkModel(
        url,
        type,
      );

  SocialLink(this.type, this.url);

  factory SocialLink.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinkToJson(this);

  @override
  List<Object?> get props => [];
}
