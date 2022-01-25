
class PutOnMarketModel {
  int? nftTokenId;
  String? nftId;
  String? tokenAddress;
  int? numberOfCopies;
  int? nftType;
  String? price;
  String? collectionAddress;

  // auction
  String? buyOutPrice;
  String? priceStep;
  String? startTime;
  String? endTime;

  PutOnMarketModel({
    this.tokenAddress,
    this.collectionAddress,
    this.nftId,
    this.nftTokenId,
    this.nftType,
    this.numberOfCopies,
    this.price,
    this.buyOutPrice,
    this.priceStep,
  });

  factory PutOnMarketModel.putOnSale({
    required int nftTokenId,
    required String  nftId,
    required int nftType,
    required String collectionAddress,
  }) {
    return PutOnMarketModel(
      nftId:  nftId,
      nftTokenId: nftTokenId,
      nftType:  nftType,
      collectionAddress:  collectionAddress,
    );
  }
}
