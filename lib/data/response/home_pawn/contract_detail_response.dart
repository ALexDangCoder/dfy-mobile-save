import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:json_annotation/json_annotation.dart';

import 'borrow_list_my_acc_response.dart';

part 'contract_detail_response.g.dart';

@JsonSerializable()
class ContractlDetailMyAccResponse {
  @JsonKey(name: 'data')
  DataResponse? data;

  ContractlDetailMyAccResponse(this.data);

  factory ContractlDetailMyAccResponse.fromJson(Map<String, dynamic> json) =>
      _$ContractlDetailMyAccResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContractlDetailMyAccResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'borrowerReputation')
  int? borrowerReputation;
  @JsonKey(name: 'cryptoCollateral')
  CryptoModelContractResponse? cryptoCollateral;
  @JsonKey(name: 'contractTerm')
  CryptoModelContractResponse? contractTerm;
  @JsonKey(name: 'lenderReputation')
  int? lenderReputation;
  @JsonKey(name: 'borrowerUserId')
  int? borrowerUserId;
  @JsonKey(name: 'borrowerWalletAddress')
  String? borrowerWalletAddress;
  @JsonKey(name: 'lenderUserId')
  int? lenderUserId;
  @JsonKey(name: 'lenderWalletAddress')
  String? lenderWalletAddress;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'remainingLoan')
  double? remainingLoan;
  @JsonKey(name: 'latestBlockchainTxn')
  String? latestBlockchainTxn;
  @JsonKey(name: 'startDate')
  int? startDate;
  @JsonKey(name: 'endDate')
  int? endDate;
  @JsonKey(name: 'defaultDate')
  int? defaultDate;
  @JsonKey(name: 'liquidationType')
  double? liquidationType;
  @JsonKey(name: 'isClaimed')
  bool? isClaimed;
  @JsonKey(name: 'bcContractId')
  int? bcContractId;
  @JsonKey(name: 'defaultReason')
  String? defaultReason;
  @JsonKey(name: 'loanToValue')
  int? loanToValue;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'nft')
  NftResponse? nft;
  @JsonKey(name: 'smartContractType')
  int? smartContractType;

  DataResponse(
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

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  ContractDetailPawn toDomain() => ContractDetailPawn(
        id,
        borrowerReputation,
        cryptoCollateral?.toDomain(),
        contractTerm?.toDomain(),
        lenderReputation,
        borrowerUserId,
        borrowerWalletAddress,
        lenderUserId,
        lenderWalletAddress,
        status,
        remainingLoan,
        latestBlockchainTxn,
        startDate,
        endDate,
        defaultDate,
        liquidationType,
        isClaimed,
        bcContractId,
        defaultReason,
        loanToValue,
        type,
        nft?.toDomain(),
        smartContractType,
      );
}

@JsonSerializable()
class CryptoModelContractResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'estimateUsdAmount')
  double? estimateUsdAmount;
  @JsonKey(name: 'cryptoAsset')
  InfoTokenAssetRespone? cryptoAsset;
  @JsonKey(name: 'expectedLoanCryptoAsset')
  InfoTokenAssetRespone? expectedLoanCryptoAsset;
  @JsonKey(name: 'expectedLoanDurationTime')
  int? expectedLoanDurationTime;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'expectedLoanDurationType')
  int? expectedLoanDurationType;
  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;
  @JsonKey(name: 'repaymentCryptoAsset')
  InfoTokenAssetRespone? repaymentCryptoAsset;
  @JsonKey(name: 'supplyCurrencyAsset')
  InfoTokenAssetRespone? supplyCurrencyAsset;
  @JsonKey(name: 'loanAmount')
  double? loanAmount;
  @JsonKey(name: 'estimateUsdLoanAmount')
  double? estimateUsdLoanAmount;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'repaymentCycleType')
  int? repaymentCycleType;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'latestBlockchainTxn')
  String? latestBlockchainTxn;
  @JsonKey(name: 'durationQty')
  int? durationQty;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'interestRate')
  int? interestRate;
  @JsonKey(name: 'riskDefault')
  int? riskDefault;
  @JsonKey(name: 'systemRisk')
  int? systemRisk;
  @JsonKey(name: 'penaltyRate')
  int? penaltyRate;

  CryptoModelContractResponse(
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

  factory CryptoModelContractResponse.fromJson(Map<String, dynamic> json) =>
      _$CryptoModelContractResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoModelContractResponseToJson(this);

  CryptoModelContract toDomain() => CryptoModelContract(
        id,
        walletAddress,
        amount,
        estimateUsdAmount,
        cryptoAsset?.toDomain(),
        expectedLoanCryptoAsset?.toDomain(),
        expectedLoanDurationTime,
        description,
        userId,
        expectedLoanDurationType,
        bcCollateralId,
        repaymentCryptoAsset?.toDomain(),
        supplyCurrencyAsset?.toDomain(),
        loanAmount,
        estimateUsdLoanAmount,
        duration,
        repaymentCycleType,
        status,
        latestBlockchainTxn,
        durationQty,
        durationType,
        interestRate,
        riskDefault,
        systemRisk,
        penaltyRate,
      );
}

@JsonSerializable()
class InfoTokenAssetRespone {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'isWhitelistCollateral')
  bool? isWhitelistCollateral;
  @JsonKey(name: 'isWhitelistSupply')
  bool? isWhitelistSupply;
  @JsonKey(name: 'usdExchange')
  String? usdExchange;
  @JsonKey(name: 'isAcceptedAsCollateral')
  bool? isAcceptedAsCollateral;
  @JsonKey(name: 'isAcceptedAsLoan')
  bool? isAcceptedAsLoan;
  @JsonKey(name: 'isAcceptedRepayment')
  bool? isAcceptedRepayment;
  @JsonKey(name: 'whitelistAsset')
  bool? whitelistAsset;
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'icon_url')
  String? iconUrl;

  factory InfoTokenAssetRespone.fromJson(Map<String, dynamic> json) =>
      _$InfoTokenAssetResponeFromJson(json);

  InfoTokenAssetRespone(
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

  Map<String, dynamic> toJson() => _$InfoTokenAssetResponeToJson(this);

  InfoTokenAsset toDomain() => InfoTokenAsset(
        id,
        isWhitelistCollateral,
        isWhitelistSupply,
        usdExchange,
        isAcceptedAsCollateral,
        isAcceptedAsLoan,
        isAcceptedRepayment,
        whitelistAsset,
        symbol,
        address,
        iconUrl,
      );
}
