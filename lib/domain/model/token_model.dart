class ModelToken {
  String tokenAddress = '';
  String nameToken = '';
  String nameShortToken = '';
  String iconToken = '';
  double balanceToken = 12313.3123123;
  double exchangeRate = 0;
  bool isShowed = false;

  ModelToken({
    required this.tokenAddress,
    required this.nameToken,
    required this.nameShortToken,
    required this.iconToken,
  });
  ModelToken.init();

  ModelToken.fromWalletCore(dynamic json)
      : tokenAddress = json['tokenAddress'].toString(),
        iconToken = json['iconUrl'],
        nameToken = json['tokenFullName'].toString(),
        nameShortToken = json['symbol'].toString(),
        isShowed = json['isShow'];
}
