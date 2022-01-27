class HistoryNFT {
  String? collectionAddress;
  int? eventDateTime;
  String? eventName;
  int? eventType;
  num? exceptedLoan;
  String? fromAddress;
  int? historyType;
  String? idRef;
  bool? isYou;
  String? marketId;
  int? nftStandard;
  int? nftTokenId;
  num? price;
  String? priceSymbol;
  bool? processing;
  int? quantity;
  String? toAddress;
  String? token;
  String? txnHash;
  String? walletAddress;

  HistoryNFT({
    this.collectionAddress,
    this.eventDateTime,
    this.eventName,
    this.eventType,
    this.exceptedLoan,
    this.fromAddress,
    this.historyType,
    this.idRef,
    this.isYou,
    this.marketId,
    this.nftStandard,
    this.nftTokenId,
    this.price,
    this.priceSymbol,
    this.processing,
    this.quantity,
    this.toAddress,
    this.token,
    this.txnHash,
    this.walletAddress,
  });
}
