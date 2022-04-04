import 'package:Dfy/domain/model/pawn/loan_request_list/loan_request_crypto_item_model.dart';

class DetailLoanRequestCryptoModel {
  int? id;
  String? collateralSymbol;
  String? loanSymbol;
  String? description;
  String? message;
  int? status;
  int? durationType;
  int? durationQty;
  int? bcCollateralId;
  int? collateralId;
  double? collateralAmount;
  P2PLenderPackageModel? p2pLenderPackageModel;
  CollateralOwnerLoanRqModel? collateralOwnerLoanRqModel;
  PawnShopPackageLoanRqModel? packageLoanRqModel;

  DetailLoanRequestCryptoModel({
    this.id,
    this.collateralSymbol,
    this.loanSymbol,
    this.description,
    this.message,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.collateralId,
    this.p2pLenderPackageModel,
    this.collateralOwnerLoanRqModel,
    this.packageLoanRqModel,
    this.collateralAmount,
  });
}

class CollateralOwnerLoanRqModel {
  String? walletAddress;
  int? reputationScore;

  CollateralOwnerLoanRqModel({this.walletAddress, this.reputationScore});
}

class PawnShopPackageLoanRqModel {
  int? id;
  String? name;
  int? type;

  PawnShopPackageLoanRqModel({this.id, this.name, this.type});
}
