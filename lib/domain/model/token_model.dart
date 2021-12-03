import 'dart:typed_data';

class ModelToken {
  String? tokenAddress;
  String? nameToken;
  String? nameShortToken;
  Uint8List? iconToken;
  double balanceToken = 1024.124412;
  double exchangeRate  = 656.24;

  ModelToken({
    this.tokenAddress,
    this.nameToken,
    this.nameShortToken,
    this.iconToken,

  });

  ModelToken.fromWalletCore(dynamic json)
      : tokenAddress = json['tokenAddress'].toString(),
        iconToken = json['iconToken'],
        nameToken = json['tokenFullName'].toString(),
        nameShortToken = json['tokenShortName'].toString();
}
