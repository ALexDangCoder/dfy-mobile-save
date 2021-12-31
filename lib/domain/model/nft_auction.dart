class NFTOnAuction {
  String? image;
  String? name;
  double? reservePrice;
  String? nftStandard;
  String? collectionAddress;
  String? collectionName;
  String? collectionId;
  String? nftId;
  String? blockChain;
  int? totalCopies;
  int? endTime;
  bool? isOwner;
  List<Properties>? properties;
  String? description;

  NFTOnAuction.init();

  NFTOnAuction(
      this.image,
      this.name,
      this.reservePrice,
      this.nftStandard,
      this.collectionAddress,
      this.collectionName,
      this.collectionId,
      this.nftId,
      this.blockChain,
      this.totalCopies,
      this.endTime,
      this.isOwner,
      this.properties,
      this.description);
}

class Properties {
  String? key;
  String? value;

  Properties(this.key, this.value);
}
