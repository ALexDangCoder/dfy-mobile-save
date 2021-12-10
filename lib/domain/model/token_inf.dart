class TokenInf {
  int? id;
  bool? whitelistCollateral;
  bool? whitelistSupply;
  double? usdExchange;
  String? symbol;
  String? address;
  String? name;
  String? iconUrl;

  TokenInf({
    this.symbol,
    this.name,
    this.id,
    this.whitelistCollateral,
    this.whitelistSupply,
    this.usdExchange,
    this.address,
    this.iconUrl,
  });
}
