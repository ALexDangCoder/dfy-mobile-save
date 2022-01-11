class CollectionModel {

  String? id;
  String? txnHash;
  String? coverCid;
  String? avatarCid;
  String? collectionName;
  int? numberOfItem;
  int? numberOfOwner;
  String? walletAddress;
  String? collectionAddress;
  String? description;
  int? nftType;
  String? collectionId;
  String? beId;
  int? standard;
  String? customUrl;
  String? featureCid;
  bool? isWhitelist;

  CollectionModel(
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
      this.isWhitelist);
}
