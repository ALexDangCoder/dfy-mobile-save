class CollateralDetail {
  int? id;
  int? userId;
  String? collateralSymbol;
  String? collateralAddress;
  double? collateralAmount;
  String? loanSymbol;
  double? loanAmount;
  String? loanAddress;
  String? description;
  int? status;
  int? durationType;
  int? durationQty;
  int? bcCollateralId;
  int? numberOfferReceived;
  String? latestBlockchainTxn;
  double? estimatePrice;
  double? expectedLoanAmount;
  String? expectedCollateralSymbol;
  double? reputation;
  String? walletAddress;
  double? completedContracts;
  bool? isActive;
  int? type;
  String? nft;
  String? nftCollateralDetailDTO;

  CollateralDetail({
    this.id,
    this.userId,
    this.collateralSymbol,
    this.collateralAddress,
    this.collateralAmount,
    this.loanSymbol,
    this.loanAmount,
    this.loanAddress,
    this.description,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.numberOfferReceived,
    this.latestBlockchainTxn,
    this.estimatePrice,
    this.expectedLoanAmount,
    this.expectedCollateralSymbol,
    this.reputation,
    this.walletAddress,
    this.completedContracts,
    this.isActive,
    this.type,
    this.nft,
    this.nftCollateralDetailDTO,
  });
}
