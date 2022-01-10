import 'package:Dfy/data/response/collection_detail/collection_detail_response.dart';

class CollectionDetailModel {
  String? id;
  String? name;
  String? owner;
  String? description;
  int? status;
  int? collectionType;
  int? collectionStandard;
  String? collectionAddress;
  String? avatarCid;
  String? coverCid;
  String? featureCid;
  int? totalNft;
  int? nftOwnerCount;
  int? totalVolumeTraded;
  List<SocialLink>? socialLinks;
  bool? isOwner;
  bool? isDefault;
  bool? isWhiteList;
  String? beId;
  String? categoryType;

  CollectionDetailModel({
    this.id,
    this.name,
    this.owner,
    this.description,
    this.status,
    this.collectionType,
    this.collectionStandard,
    this.collectionAddress,
    this.avatarCid,
    this.coverCid,
    this.featureCid,
    this.totalNft,
    this.nftOwnerCount,
    this.totalVolumeTraded,
    this.socialLinks,
    this.isOwner,
    this.isDefault,
    this.isWhiteList,
    this.beId,
    this.categoryType,
  });
}
