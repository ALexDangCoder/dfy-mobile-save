class OfferSentDetailCryptoCollateralModel {
  int? id;
  int? userId;
  String? collateralSymbol;
  double? collateralAmount;
  String? loanSymbol;
  String? description;
  int? status;
  int? durationType;
  int? durationQty;
  int? bcCollateralId;
  int? numberOfferReceived;
  String? latestBlockchainTxn;
  double? estimatePrice;
  String? expectedCollateralSymbol;
  int? reputation;
  String? walletAddress;
  int? completedContracts;
  int? type;

  OfferSentDetailCryptoCollateralModel({
    this.id,
    this.userId,
    this.collateralSymbol,
    this.collateralAmount,
    this.loanSymbol,
    this.description,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.numberOfferReceived,
    this.latestBlockchainTxn,
    this.estimatePrice,
    this.expectedCollateralSymbol,
    this.reputation,
    this.walletAddress,
    this.completedContracts,
    this.type,
  });
}