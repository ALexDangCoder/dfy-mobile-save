class TokenModel {
  String? symbol;
  String? name;
  String? imageUrl;
  int? id;
  bool? isWhitelistCollateral;
  bool? isWhitelistSupply;
  double? usdExchange;
  bool? isAcceptedAsCollateral;
  bool? isAcceptedAsLoan;
  bool? isAcceptedRepayment;
  String? address;

  TokenModel({
    this.symbol,
    this.name = '',
    this.imageUrl = '',
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
