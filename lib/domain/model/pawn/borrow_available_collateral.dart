class BorrowAvailableCollateral {
  int? totalAvailableCollateral;
  int? totalContract;
  double? totalValue;
  int? reputation;
  List<String>? symbol;

  BorrowAvailableCollateral({
    this.totalAvailableCollateral,
    this.totalValue,
    this.reputation,
    this.symbol,
    this.totalContract,
  });
}

class CollateralUser {

  int? id;
  String? collateralSymbol;
  String? collateralAddress;
  num? collateralAmount;
  String? loanSymbol;
  int? durationQty;
  int? durationType;
  NftCollateral? nftCollateral;

  CollateralUser({
      this.id,
      this.collateralSymbol,
      this.collateralAddress,
      this.collateralAmount,
      this.loanSymbol,
      this.durationQty,
      this.durationType,
      this.nftCollateral});
}

class SignedContractUser {

  int? id;
  String? collateralSymbol;
  String? collateralAddress;
  num? collateralAmount;
  String? loanSymbol;
  int? durationQty;
  int? durationType;
  num? interestRate;
  NftCollateral? nftCollateral;

  SignedContractUser({
    this.id,
    this.collateralSymbol,
    this.collateralAddress,
    this.collateralAmount,
    this.interestRate,
    this.loanSymbol,
    this.durationQty,
    this.durationType,
    this.nftCollateral});
}

class NftCollateral {
  String? nftId;
  String? collectionAddress;
  int? nftTokenId;

  NftCollateral({this.nftId, this.collectionAddress, this.nftTokenId});
}

