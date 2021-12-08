class ModelToken {
  String tokenAddress = '';
  String nameToken = '';
  String nameShortToken = '';
  String iconToken = '';
  double balanceToken = 0.0;
  bool isShow = false;
  double exchangeRate = 0;
  String walletAddress = '';

  ModelToken({
    required this.balanceToken,
    required this.tokenAddress,
    required this.nameToken,
    required this.nameShortToken,
    required this.iconToken,
  });

  ModelToken.init();

  ModelToken.fromWalletCore(dynamic json)
      : tokenAddress = json['tokenAddress'].toString(),
        walletAddress = json['walletAddress'].toString(),
        iconToken = json['iconUrl'],
        nameToken = json['tokenFullName'].toString(),
        isShow = json['isShow'],
        nameShortToken = json['symbol'].toString();
}
