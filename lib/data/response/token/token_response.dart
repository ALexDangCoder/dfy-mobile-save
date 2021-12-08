import 'package:Dfy/domain/model/token_inf.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'token_response.g.dart';

@JsonSerializable()
class TokenResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'isWhitelistCollateral')
  bool? isWhitelistCollateral;
  @JsonKey(name: 'isWhitelistSupply')
  bool? isWhitelistSupply;
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
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
    this.usdExchange,
    this.address,
    this.symbol,
    this.iconUrl,
  );

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponseToJson(this);

  @override
  List<Object?> get props => [];

  TokenInf toDomain() => TokenInf(
        id: id,
        isWhitelistCollateral: isWhitelistCollateral,
        symbol: symbol,
        isWhitelistSupply: isWhitelistSupply,
        usdExchange: usdExchange,
        address: address,
      );
}
