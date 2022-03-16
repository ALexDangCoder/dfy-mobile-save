class SendOfferLendCryptoModel {
  int? id;
  int? userId;
  String? walletAddress;
  double? loanAmount;
  int? repaymentCycleType;
  int? status;
  String? latestBlockchainTxn;
  int? durationQty;
  int? durationType;
  double? interestRate;
  double? liquidationThreshold;
  String? description;
  String? bcOfferId;
  double? loanToValue;
  double? smartContractType;
  String? smartContractAddress;
  String? txnId;
  String? txnIdAccept;

  SendOfferLendCryptoModel({
    this.id,
    this.userId,
    this.walletAddress,
    this.loanAmount,
    this.repaymentCycleType,
    this.status,
    this.latestBlockchainTxn,
    this.durationQty,
    this.durationType,
    this.interestRate,
    this.liquidationThreshold,
    this.description,
    this.bcOfferId,
    this.loanToValue,
    this.smartContractType,
    this.smartContractAddress,
    this.txnId,
    this.txnIdAccept,
  });
}
