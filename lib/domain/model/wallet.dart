class Wallet {
  final String? name;
  final String? address;
  final bool? isImportWallet;

  Wallet({this.name, this.address, this.isImportWallet});

//"arrayOf(
// walletName: String
// walletAddress: String,
// isImportWallet: bool
// )"
  Wallet.fromJson(dynamic json)
      : name = json['walletName'].toString(),
        isImportWallet = json['isImportWallet'] as bool,
        address = json['walletAddress'].toString();
}
