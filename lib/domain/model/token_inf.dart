class TokenInf {
  int? id;
  bool? isWhitelistCollateral;
  bool? isWhitelistSupply;
  double? usdExchange;
  String? symbol;
  String? address;
  String? name;
  String? iconUrl;

  TokenInf({
    this.symbol,
    this.name = '',
    this.id,
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
    this.usdExchange,
    this.address,
    this.iconUrl,
  });
}
