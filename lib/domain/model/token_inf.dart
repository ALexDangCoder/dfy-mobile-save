class TokenInf {
  String? symbol;
  String? name;
  String? iconUrl;
  int? id;
  bool? isWhitelistCollateral;
  bool? isWhitelistSupply;
  double? usdExchange;
  bool? isAcceptedAsCollateral;
  bool? isAcceptedAsLoan;
  bool? isAcceptedRepayment;
  String? address;

  TokenInf({
    this.symbol,
    this.name = '',
    this.iconUrl,
    this.id,
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
    this.usdExchange,
    this.isAcceptedAsCollateral,
    this.isAcceptedAsLoan,
    this.isAcceptedRepayment,
    this.address,
  });
}
