import 'package:Dfy/data/response/token/price_token_response.dart';
import 'package:Dfy/domain/model/token_price_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_price_token_response.g.dart';

@JsonSerializable()
class ListPriceTokenResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'rows')
  List<PriceTokenResponse>? rows;

  ListPriceTokenResponse(this.rc, this.rd, this.total, this.rows);

  factory ListPriceTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ListPriceTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListPriceTokenResponseToJson(this);

  @override
  List<Object?> get props => [];

  List<TokenPrice>? toDomain() => rows?.map((e) => e.toDomain()).toList();
}
