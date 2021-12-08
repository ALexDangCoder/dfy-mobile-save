class TokenModel {
  int? tokenId;
  String? iconToken;
  double? amountToken;
  String? nameToken;
  String? nameTokenSymbol;
  double? price;
  bool? isShow;

  TokenModel({
    this.tokenId,
    this.iconToken,
    this.amountToken,
    this.nameToken,
    this.nameTokenSymbol,
    this.price,
    this.isShow,
  });

  // "jsonTokens*: String
  // arrayOf(
  // walletAddress*: String
  // tokenAddress*: String
  // tokenFullName*: String
  // iconUrl*: String
  // symbol*: String
  // decimal*: Int
  // )"
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['walletAddress'] = this.walletAddress;
  //   data['tokenAddress'] = this.tokenAddress;
  //   data['tokenFullName'] = this.tokenFullName;
  //   data['iconUrl'] = this.iconUrl;
  //   data['symbol'] = this.symbol;
  //   data['decimal'] = this.decimal;
  //   return data;
  // }

}
