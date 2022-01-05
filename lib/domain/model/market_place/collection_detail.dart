import 'package:Dfy/data/response/collection_detail/collection_detail_res.dart';

class CollectionDetailModel {
  String? id;
  String? name;
  String? description;
  String? owner;
  int? status;
  String? collectionAddress;
  String? avatarCid;
  String? coverCid;
  String? featureCid;
  String? txnHash;
  String? ownerAccount;
  int? createAt;
  int? updateAt;
  int? totalNft;
  int? nftOwnerCount;
  int? totalVolumeTraded;
  String? collectionType;
  String? collectionStandard;
  String? customUrl;
  double? royalty;
  List<SocialLink>? socialLinks;
  String? categoryId;
  String? royaltyToken;
  bool? isOwner;
  bool? isDefault;
  bool? isWhiteList;

  CollectionDetailModel(
      {this.id,
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
      this.isWhiteList});
}
