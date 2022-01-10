class CollectionModel {
  String? id;
  String? name;
  String? description;
  int? type;
  String? avatarCid;
  String? coverCid;
  int? totalNft;
  int? nftOwnerCount;
  int? totalVolumeTraded;
  bool? isFeature;

  CollectionModel({
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
  });
}
