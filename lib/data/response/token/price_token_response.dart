import 'package:Dfy/domain/model/token_price_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_token_response.g.dart';

@JsonSerializable()
class PriceTokenResponse extends Equatable {
  @JsonKey(name: 'tokenSymbol')
  String? tokenSymbol;
  @JsonKey(name: 'price')
  double? price;

  PriceTokenResponse(this.tokenSymbol, this.price);

  factory PriceTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$PriceTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PriceTokenResponseToJson(this);

  @override
  List<Object?> get props => [];

  TokenPrice toDomain() => TokenPrice(
        tokenSymbol,
        price,
      );
}
