class CryptoCollateralModel {
  String? name;
  String? collateralSymbol;
  double? collateralAmount;
  String? loanTokenSymbol;
  num? duration;
  int? durationType;
  bool? isSelect;
  int? bcCollateralId;
  String? txhHash;

  CryptoCollateralModel({
    this.name,
    this.collateralSymbol,
    this.collateralAmount,
    this.loanTokenSymbol,
    this.duration,
    this.durationType,
    this.isSelect,
    this.bcCollateralId,
    this.txhHash,
  });
}
