class CollateralResultModel {
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
  String? expectedLoanAmount;
  String? expectedCollateralSymbol;
  int? reputation;
  String? walletAddress;
  int? completedContracts;
  bool? isActive;
  int? type;
  String? nftCollateralDetailDTO;
  String? nft;

  CollateralResultModel({
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
    this.nftCollateralDetailDTO,
    this.nft,
  });
}
