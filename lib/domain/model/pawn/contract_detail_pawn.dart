class ContractDetailPawn {
  int? id;
  int? borrowerReputation;
  CryptoModelContract? cryptoCollateral;
  CryptoModelContract? contractTerm;
  int? lenderReputation;
  int? borrowerUserId;
  String? borrowerWalletAddress;
  int? lenderUserId;
  String? lenderWalletAddress;
  int? status;
  double? remainingLoan;
  String? latestBlockchainTxn;
  int? startDate;
  int? endDate;
  int? defaultDate;
  double? liquidationType;
  bool? isClaimed;
  int? bcContractId;
  String? defaultReason;
  int? loanToValue;
  int? type;
  int? nft;
  int? smartContractType;

  ContractDetailPawn.name({this.id});

  ContractDetailPawn(
    this.id,
    this.borrowerReputation,
    this.cryptoCollateral,
    this.contractTerm,
    this.lenderReputation,
    this.borrowerUserId,
    this.borrowerWalletAddress,
    this.lenderUserId,
    this.lenderWalletAddress,
    this.status,
    this.remainingLoan,
    this.latestBlockchainTxn,
    this.startDate,
    this.endDate,
    this.defaultDate,
    this.liquidationType,
    this.isClaimed,
    this.bcContractId,
    this.defaultReason,
    this.loanToValue,
    this.type,
    this.nft,
    this.smartContractType,
  );
}

class CryptoModelContract {
  int? id;
  String? walletAddress;
  double? amount;
  double? estimateUsdAmount;
  InfoTokenAsset? cryptoAsset;
  InfoTokenAsset? expectedLoanCryptoAsset;
  int? expectedLoanDurationTime;
  String? description;
  int? userId;
  int? expectedLoanDurationType;
  int? bcCollateralId;
  InfoTokenAsset? repaymentCryptoAsset;
  InfoTokenAsset? supplyCurrencyAsset;
  double? loanAmount;
  double? estimateUsdLoanAmount;
  int? duration;
  int? repaymentCycleType;
  int? status;
  String? latestBlockchainTxn;
  int? durationQty;
  int? durationType;
  int? interestRate;
  int? riskDefault;
  String? systemRisk;
  int? penaltyRate;

  CryptoModelContract(
    this.id,
    this.walletAddress,
    this.amount,
    this.estimateUsdAmount,
    this.cryptoAsset,
    this.expectedLoanCryptoAsset,
    this.expectedLoanDurationTime,
    this.description,
    this.userId,
    this.expectedLoanDurationType,
    this.bcCollateralId,
    this.repaymentCryptoAsset,
    this.supplyCurrencyAsset,
    this.loanAmount,
    this.estimateUsdLoanAmount,
    this.duration,
    this.repaymentCycleType,
    this.status,
    this.latestBlockchainTxn,
    this.durationQty,
    this.durationType,
    this.interestRate,
    this.riskDefault,
    this.systemRisk,
    this.penaltyRate,
  );
}

class InfoTokenAsset {
  int? id;
  bool? isWhitelistCollateral;
  bool? isWhitelistSupply;
  String? usdExchange;
  bool? isAcceptedAsCollateral;
  bool? isAcceptedAsLoan;
  bool? isAcceptedRepayment;
  bool? whitelistAsset;
  String? symbol;
  String? address;
  String? iconUrl;

  InfoTokenAsset(
    this.id,
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
    this.usdExchange,
    this.isAcceptedAsCollateral,
    this.isAcceptedAsLoan,
    this.isAcceptedRepayment,
    this.whitelistAsset,
    this.symbol,
    this.address,
    this.iconUrl,
  );
}
