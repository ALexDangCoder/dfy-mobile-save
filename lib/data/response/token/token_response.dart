import 'package:Dfy/domain/model/token_inf.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'whitelistCollateral')
  bool? whitelistCollateral;
  @JsonKey(name: 'whitelistSupply')
  bool? whitelistSupply;
  @JsonKey(name: 'usdExchange')
  double? usdExchange;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;

  TokenResponse(
    this.id,
    this.whitelistCollateral,
    this.whitelistSupply,
    this.usdExchange,
    this.address,
    this.symbol,
    this.iconUrl,
    this.name,
  );

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  @override
  List<Object?> get props => [];

  TokenInf toDomain() => TokenInf(
        name: name,
        id: id,
        whitelistCollateral: whitelistCollateral,
        symbol: symbol,
        whitelistSupply: whitelistSupply,
        usdExchange: usdExchange,
        address: address,
      );
}
