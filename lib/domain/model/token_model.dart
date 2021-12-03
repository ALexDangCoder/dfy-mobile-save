import 'dart:typed_data';

class ModelToken {
  String tokenAddress;
  String nameToken;
  String nameShortToken;
  Uint8List iconToken;
  double balanceToken = 12313.3123123;
  double exchangeRate = 0;


  ModelToken({
    required this.tokenAddress,
    required this.nameToken,
    required this.nameShortToken,
    required this.iconToken,
  });

  ModelToken.fromWalletCore(dynamic json)
      : tokenAddress = json['tokenAddress'].toString(),
        iconToken = json['iconToken'],
        nameToken = json['tokenFullName'].toString(),
        nameShortToken = json['tokenShortName'].toString();
}
