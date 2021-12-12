import 'package:Dfy/domain/model/token_inf.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'usdExchange')
  double? usdExchange;
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;
  @JsonKey(name: 'whitelistCollateral')
  bool? whitelistCollateral;
  @JsonKey(name: 'whitelistSupply')
  bool? whitelistSupply;

  TokenResponse(
    this.id,
    this.usdExchange,
    this.symbol,
    this.address,
    this.name,
    this.iconUrl,
    this.whitelistCollateral,
    this.whitelistSupply,
  );

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  @override
  List<Object?> get props => [];

  TokenInf toDomain() => TokenInf(
        id: id,
        usdExchange: usdExchange,
        symbol: symbol,
        address: address,
        name: name,
        iconUrl: iconUrl,
        whitelistCollateral: whitelistCollateral,
        whitelistSupply: whitelistSupply,
      );
}
