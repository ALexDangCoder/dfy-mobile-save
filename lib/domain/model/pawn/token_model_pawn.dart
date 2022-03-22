class TokenModelPawn {
  String? id;
  String? symbol;
  String? address;
  String? url;
  double? amount;
  bool isCheck;

  TokenModelPawn({
    this.id,
    this.symbol,
    this.address,
    this.isCheck = false,
    this.url,
    this.amount,
  });
}
