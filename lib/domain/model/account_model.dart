class AccountModel {
  String? url;
  String? addressWallet;
  String? nameWallet;
  double? amountWallet;
  bool? imported;
  bool? isCheck;
  String? shortNameToken;

  AccountModel({
    this.url,
    this.addressWallet,
    this.nameWallet,
    this.amountWallet,
    this.imported,
    this.isCheck,
    this.shortNameToken,
  });
}
