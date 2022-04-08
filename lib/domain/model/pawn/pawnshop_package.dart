import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';

class PawnshopPackage {
  List<AcceptableAssetsAsCollateral>? acceptableAssetsAsCollateral;
  int? id;
  num? interest;
  num? interestMax;
  num? interestMin;
  bool? isFavourite;
  num? loanToValue;
  int? durationQtyType;
  int? durationQtyTypeMin;
  int? durationQtyTypeMax;
  Pawnshop? pawnshop;
  int? type;
  int? status;
  int? signContracts;
  List<RepaymentToken>? repaymentToken;
  List<LoanToken>? loanToken;
  String? associatedWalletAddress;
  int? bcPackageId;
  num? allowedLoanMax;
  num? allowedLoanMin;
  String? name;
  double? available;
  num? liquidationThreshold;
  int? recurringInterest;
  num? pawnShopId;
  num? totalSentOffer;
  List<InfoTokenAsset>? collateralTokens;

  PawnshopPackage({
    this.available,
    this.pawnShopId,
    this.totalSentOffer,
    this.acceptableAssetsAsCollateral,
    this.id,
    this.interest,
    this.interestMax,
    this.interestMin,
    this.isFavourite,
    this.loanToValue,
    this.collateralTokens,
    this.durationQtyType,
    this.durationQtyTypeMin,
    this.durationQtyTypeMax,
    this.pawnshop,
    this.type,
    this.status,
    this.signContracts,
    this.repaymentToken,
    this.loanToken,
    this.associatedWalletAddress,
    this.bcPackageId,
    this.allowedLoanMax,
    this.allowedLoanMin,
    this.name,
    this.liquidationThreshold,
    this.recurringInterest,
  });
}

class Pawnshop {
  String? address; //
  String? avatar; //
  String? cover; //
  String? name; //
  int? id; //
  int? type; //
  int? userId; //
  bool? isKYC;
  bool? isTrustedLender;
  int? reputation; //
  String? walletAddress; //
  String? email;
  String? description;
  String? phoneNumber;
  int? createAt;
  int? updateAt;

  Pawnshop({
    this.address,
    this.avatar,
    this.cover,
    this.id,
    this.type,
    this.userId,
    this.isKYC,
    this.isTrustedLender,
    this.name,
    this.reputation,
    this.walletAddress,
    this.email,
    this.description,
    this.phoneNumber,
    this.createAt,
    this.updateAt,
  });
}
