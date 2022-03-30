import 'package:Dfy/domain/model/home_pawn/nft_pawn_model.dart';

class LenderContractNftModel {
  int? id;
  String? supplyCurrency;
  double? supplyCurrencyAmount;
  double? estimateUsdSupplyCurrencyAmount;
  String? collateral;
  double? collateralAmount;
  double? estimateUsdCollateralAmount;
  int? interestPerYear;
  int? duration;
  int? durationType;
  String? lenderWalletAddress;
  int? lenderReputation;
  String? borrowerWalletAddress;
  int? borrowerReputation;
  int? status;
  bool? isClaimed;
  int? bcContractId;
  int? type;
  NFTPawnModel? nft;

  LenderContractNftModel(
    this.id,
    this.supplyCurrency,
    this.supplyCurrencyAmount,
    this.estimateUsdSupplyCurrencyAmount,
    this.collateral,
    this.collateralAmount,
    this.estimateUsdCollateralAmount,
    this.interestPerYear,
    this.duration,
    this.durationType,
    this.lenderWalletAddress,
    this.lenderReputation,
    this.borrowerWalletAddress,
    this.borrowerReputation,
    this.status,
    this.isClaimed,
    this.bcContractId,
    this.type,
    this.nft,
  );
}
