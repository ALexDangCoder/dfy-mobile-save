import 'package:Dfy/domain/model/home_pawn/nft_pawn_model.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/detail_loan_request_crypto_model.dart';

class LoanRequestCryptoModel {
  int? id;
  String? collateralSymbol;
  double? collateralAmount;
  String? loanSymbol;
  String? description;
  String? message;
  int? status;
  int? durationType;
  int? durationQty;
  int? bcCollateralId;
  int? collateralId;
  P2PLenderPackageModel? p2pLenderPackageModel;
  CollateralOwnerLoanRqModel? collateralOwner;
  double? expectedLoanAmount;
  String? expectedLoanSymbol;
  NFTPawnModel? nftModel;

  LoanRequestCryptoModel({
    this.id,
    this.collateralSymbol,
    this.collateralOwner,
    this.nftModel,
    this.collateralAmount,
    this.loanSymbol,
    this.description,
    this.message,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.collateralId,
    this.expectedLoanSymbol,
    this.expectedLoanAmount,
    this.p2pLenderPackageModel,
  });
}

class P2PLenderPackageModel {
  String? associatedWalletAddress;
  int? id;
  String? name;
  int? type;

  P2PLenderPackageModel({
    this.associatedWalletAddress,
    this.id,
    this.name,
    this.type,
  });
}
