class CollectionCategoryModel {
  String? avatarId;
  String? collectionName;
  int? collectionType;
  String? coverId;
  String? description;
  String? collectionAddress;
  String? featureId;
  String? id;
  bool? isWhiteList;
  int? nftOwnerCount;
  int? totalNft;

  CollectionCategoryModel({
    this.isWhiteList,
    this.avatarId,
    this.collectionName,
    this.collectionType,
    this.coverId,
    this.description,
    this.featureId,
    this.id,
    this.nftOwnerCount,
    this.totalNft,
    this.collectionAddress,
  });
}
