class NftCollectionExploreModel {
  String? id;
  int? position;
  int? type;
  double? price;
  String? name;
  String? itemId;
  String? fileCid;
  String? nftId;
  int? marketType;
  int? startTime;
  int? endTime;
  double? reservePrice;
  double? buyOutPrice;
  String? token;
  int? numberOfCopies;
  int? totalCopies;
  String? fileType;
  String? coverCid;
  dynamic isReservePrice;

  ///Explore categories
  String? avatarCid;
  String? bannerCid;
  int? displayCol;
  int? displayRow;

  ///outstading collection
  String? featureCid;
  String? collectionAddress;
  int? totalNft;
  int? nftOwnerCount;
  int? collectionType;

  NftCollectionExploreModel({
    this.id,
    this.position,
    this.type,
    this.price,
    this.name,
    this.itemId,
    this.fileCid,
    this.nftId,
    this.marketType,
    this.startTime,
    this.endTime,
    this.reservePrice,
    this.buyOutPrice,
    this.token,
    this.numberOfCopies,
    this.totalCopies,
    this.fileType,
    this.coverCid,
    this.isReservePrice,
    this.avatarCid,
    this.bannerCid,
    this.displayCol,
    this.displayRow,
    this.featureCid,
    this.totalNft,
    this.nftOwnerCount,
    this.collectionType,
    this.collectionAddress,
  });
}
