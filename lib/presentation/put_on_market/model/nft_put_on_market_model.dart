
class PutOnMarketModel {
  int? nftTokenId;
  String? nftId;
  String? tokenAddress;
  int? numberOfCopies;
  int? nftType;
  String? price;
  String? txtHash;
  String? collectionId;

  PutOnMarketModel({
    this.tokenAddress,
    this.collectionId,
    this.nftId,
    this.nftTokenId,
    this.nftType,
    this.numberOfCopies,
    this.price,
    this.txtHash,
  });

  factory PutOnMarketModel.putOnSale({
    required int nftTokenId,
    required String  nftId,
    required String txtHash,
    required int nftType,
    required String collectionId,
  }) {
    return PutOnMarketModel(
      nftId:  nftId,
      nftTokenId: nftTokenId,
      txtHash:  txtHash,
      nftType:  nftType,
      collectionId:  collectionId,
    );
  }
}
