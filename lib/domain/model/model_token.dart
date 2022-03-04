class ModelToken {
  String tokenAddress = '0x';
  String nameToken = 'DFY';
  String nameShortToken = 'DFY';
  String iconToken = 'null';
  double exchangeRate = 0;
  String walletAddress = '0x';
  int decimal = 0;

  double balanceToken = 0.0;
  bool isShow = false;
  bool isImport = false;

  ModelToken({
    required this.tokenAddress,
    required this.nameToken,
    required this.nameShortToken,
    required this.iconToken,
    required this.exchangeRate,
    required this.walletAddress,
    required this.decimal,
    required this.isImport,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'tokenAddress': tokenAddress,
        'nameToken': nameToken,
        'nameShortToken': nameShortToken,
        'iconToken': iconToken,
        'exchangeRate': exchangeRate,
        'walletAddress': walletAddress,
        'decimal': decimal,
        'isImport': isImport,
      };

  ModelToken.init();

  ModelToken.fromWalletCore(dynamic json)
      : tokenAddress = json['tokenAddress'].toString(),
        //
        walletAddress = json['walletAddress'].toString(),
        //
        iconToken = json['iconUrl'].toString(),
        //
        nameToken = json['tokenFullName'].toString(),
        //
        isShow = json['isShow'],
        //
        decimal = json['decimal'],
        //
        exchangeRate = json['exchangeRate'],
        //
        nameShortToken = json['symbol'].toString(),
        //
        isImport = json['isImport']; //
}
