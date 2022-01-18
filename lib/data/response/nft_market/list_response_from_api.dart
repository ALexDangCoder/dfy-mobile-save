import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'nft_market_response.dart';

part 'list_response_from_api.g.dart';

@JsonSerializable()
class ListNftResponseFromApi extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'rows')
  List<NftMarketResponse>? rows;

  ListNftResponseFromApi(this.rc, this.rd, this.total, this.rows);

  factory ListNftResponseFromApi.fromJson(Map<String, dynamic> json) =>
      _$ListNftResponseFromApiFromJson(json);

  Map<String, dynamic> toJson() => _$ListNftResponseFromApiToJson(this);

  @override
  List<Object?> get props => [];

  List<NftMarket>? toDomain() => rows?.map((e) => e.toDomain()).toList();
}
