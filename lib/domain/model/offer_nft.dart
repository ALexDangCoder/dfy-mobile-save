class OfferDetail {
  int? id;
  String? addressLender;
  num? reputation;
  SupplyCurrency? supplyCurrency;
  int? duration;
  int? durationType;
  num? interestPerYear;
  num? riskDefault;
  int? status;
  int? collateralId;
  num? bcOfferId;
  num? bcCollateralId;
  num? liquidationThreshold;
  int? createAt;
  String? name;

  OfferDetail({
    this.id,
    this.addressLender,
    this.reputation,
    this.supplyCurrency,
    this.duration,
    this.durationType,
    this.interestPerYear,
    this.riskDefault,
    this.createAt,
    this.status,
    this.collateralId,
    this.bcOfferId,
    this.bcCollateralId,
    this.liquidationThreshold,
    this.name,
  });
}

class SupplyCurrency {
  String? symbol;
  double? amount;
  String? tokenAddress;

  SupplyCurrency({this.symbol, this.amount, this.tokenAddress});
}
