
import 'package:json_annotation/json_annotation.dart';
part 'model_token.g.dart';
@JsonSerializable()
class ModelToken {
  @JsonKey(name: 'tokenAddress')
  String tokenAddress = '';
  @JsonKey(name: 'nameToken')
  String nameToken = '';
  @JsonKey(name: 'nameShortToken')
  String nameShortToken = '';
  @JsonKey(name: 'iconToken')
  String iconToken = '';
  @JsonKey(name: 'balanceToken')
  double balanceToken = 0.0;
  @JsonKey(name: 'isShow')
  bool isShow = false;
  @JsonKey(name: 'exchangeRate')
  double exchangeRate = 0;
  @JsonKey(name: 'walletAddress')
  String walletAddress = '';
  @JsonKey(name: 'decimal')
  double decimal = 0;
  ModelToken({
    required this.balanceToken,
    required this.tokenAddress,
    required this.nameToken,
    required this.nameShortToken,
    required this.iconToken,
    required this.exchangeRate,
    required this.walletAddress,
    required this.decimal,
  });
  factory ModelToken.fromJson(Map<String, dynamic> json) =>
      _$ModelTokenFromJson(json);

  Map<String, dynamic> toJson() => _$ModelTokenToJson(this);

  ModelToken.init();

  ModelToken.fromWalletCore(dynamic json)
      : tokenAddress = json['tokenAddress'].toString(),
        walletAddress = json['walletAddress'].toString(),
        iconToken = json['iconUrl'],
        nameToken = json['tokenFullName'].toString(),
        isShow = json['isShow'],
        nameShortToken = json['symbol'].toString();
}
