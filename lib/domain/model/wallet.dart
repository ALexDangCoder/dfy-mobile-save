class Wallet {
  final String? name;
  final String? address;

  Wallet({this.name, this.address});

  Wallet.fromJson(dynamic json)
      : name = json['walletName'].toString(),
        address = json['walletAddress'].toString();
}
