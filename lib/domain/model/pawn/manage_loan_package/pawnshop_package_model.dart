import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';

class PawnShopPackageModel {
  int? id;
  int? pawnShopId;
  int? status;
  String? name;
  int? type;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  int? durationQtyType;
  int? durationQtyMin;
  int? durationQtyMax;
  String? associatedWalletAddress;
  int? bcPackageId;
  int? loanToValue;
  int? interest;
  int? liquidationThreshold;
  int? recurringInterest;
  double? allowedLoanMax;
  double? allowedLoanMin;
  int? collateralReceived;
  List<InfoTokenAsset>? loanTokens;
  List<InfoTokenAsset>? collateralTokens;
  List<InfoTokenAsset>? repaymentTokens;

  PawnShopPackageModel({
    this.id,
    this.pawnShopId,
    this.status,
    this.name,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.durationQtyType,
    this.durationQtyMin,
    this.durationQtyMax,
    this.associatedWalletAddress,
    this.bcPackageId,
    this.loanToValue,
    this.interest,
    this.liquidationThreshold,
    this.recurringInterest,
    this.allowedLoanMax,
    this.allowedLoanMin,
    this.collateralReceived,
    this.loanTokens,
    this.collateralTokens,
    this.repaymentTokens,
  });
}
