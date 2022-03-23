class OfferSentCryptoModel {
  int? id;
  SupplyCurrencyModel? supplyCurrency;
  int? durationQty;
  int? durationType;
  int? interestRate;
  int? status;
  String? description;
  int? riskDefault;
  int? bcOfferId;
  int? bcCollateralId;
  int? liquidationThreshold;
  String? lenderWalletAddress;

  OfferSentCryptoModel({
    this.id,
    this.supplyCurrency,
    this.durationQty,
    this.durationType,
    this.interestRate,
    this.status,
    this.description,
    this.riskDefault,
    this.bcOfferId,
    this.bcCollateralId,
    this.liquidationThreshold,
    this.lenderWalletAddress,
  });
}

class SupplyCurrencyModel {
  String? symbol;
  double? amount;
  String? address;

  SupplyCurrencyModel({this.symbol, this.amount, this.address});
}
