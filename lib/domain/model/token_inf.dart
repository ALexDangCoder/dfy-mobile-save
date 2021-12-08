class TokenInf {
  String? id;
  bool? isWhitelistCollateral;
  bool? isWhitelistSupply;
  double? usdExchange;
  String? iconUrl;
  String? symbol;
  String? address;
  String? name;

  TokenInf({
    this.symbol,
    this.name = '',
    this.iconUrl,
    this.id,
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
    this.usdExchange,
    this.address,
  });
}
