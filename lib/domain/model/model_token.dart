class ModelToken {
  String tokenAddress = '';
  String nameToken = '';
  String nameShortToken = '';
  String iconToken = '';
  double exchangeRate = 0;
  String walletAddress = '';
  double decimal = 0;

  double balanceToken = 0.0;
  bool isShow = false;

  ModelToken({
    required this.tokenAddress,
    required this.nameToken,
    required this.nameShortToken,
    required this.iconToken,
    required this.exchangeRate,
    required this.walletAddress,
    required this.decimal,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tokenAddress': tokenAddress,
        'nameToken': nameToken,
        'nameShortToken': nameShortToken,
        'iconToken': iconToken,
        'exchangeRate': exchangeRate,
        'walletAddress': walletAddress,
        'decimal': decimal,
      };

  ModelToken.init();

  ModelToken.fromWalletCore(dynamic json)
      : tokenAddress = json['tokenAddress'].toString(),
        walletAddress = json['walletAddress'].toString(),
        iconToken = json['iconUrl'],
        nameToken = json['tokenFullName'].toString(),
        isShow = json['isShow'],
        nameShortToken = json['symbol'].toString();
}
