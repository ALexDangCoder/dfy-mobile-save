class LoanTokenModel {
  int? id;
  String? symbol;
  String? address;
  bool? isWhitelistCollateral;
  bool? isWhitelistSupply;
  bool? whitelistAsset;
  bool? isApplyVesting;
  bool? isExchangeMiles;
  String? coinGeckoId;
  String? name;
  String? iconUrl;

  LoanTokenModel({
    this.id,
    this.symbol,
    this.address,
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
    this.whitelistAsset,
    this.isApplyVesting,
    this.isExchangeMiles,
    this.coinGeckoId,
    this.name,
    this.iconUrl,
  });
}
