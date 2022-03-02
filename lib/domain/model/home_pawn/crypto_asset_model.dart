class CryptoAssetModel {
  int? id;
  String? symbol;
  String? address;
  bool? isWhitelistCollateral;
  bool? isWhitelistSupply;

  CryptoAssetModel({
    this.id,
    this.symbol,
    this.address,
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
  });
}
