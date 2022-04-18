class OfferSentDetailCryptoModel {
  int? id;

  int? userId;

  String? walletAddress;

  int? collateralId;

  int? bcCollateralId;

  int? point;

  int? status;

  String? description;

  int? offerId;

  String? supplyCurrencySymbol;

  double? loanAmount;

  double? estimate;

  String? repaymentToken;

  int? repaymentCycleType;

  String? latestBlockchainTxn;

  int? durationQty;

  int? durationType;

  int? interestRate;

  double? loanToValue;

  int? createdAt;

  int? bcOfferId;

  double? liquidationThreshold;

  OfferSentDetailCryptoModel({
    this.id,
    this.userId,
    this.walletAddress,
    this.collateralId,
    this.bcCollateralId,
    this.point,
    this.status,
    this.description,
    this.offerId,
    this.supplyCurrencySymbol,
    this.loanAmount,
    this.estimate,
    this.repaymentToken,
    this.repaymentCycleType,
    this.latestBlockchainTxn,
    this.durationQty,
    this.durationType,
    this.interestRate,
    this.loanToValue,
    this.createdAt,
    this.bcOfferId,
    this.liquidationThreshold,
  });
}
