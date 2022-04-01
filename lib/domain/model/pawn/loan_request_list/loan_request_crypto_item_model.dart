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

  LoanRequestCryptoModel({
    this.id,
    this.collateralSymbol,
    this.collateralAmount,
    this.loanSymbol,
    this.description,
    this.message,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.collateralId,
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
