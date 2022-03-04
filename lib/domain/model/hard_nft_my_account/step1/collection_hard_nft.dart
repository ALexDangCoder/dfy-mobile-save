import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';

class CollectionHardNft {
  String? id;
  String? name;
  String? avatarCid;
  String? collectionAddress;
  bool? isWhiteList;
  CollectionTypeAssetHardNft? collectionType;

  CollectionHardNft({
    this.id,
    this.name,
    this.avatarCid,
    this.collectionAddress,
    this.isWhiteList,
    this.collectionType,
  });
}
