import 'package:Dfy/data/response/market_place/list_type_nft_collection_explore_res.dart';
import 'package:Dfy/domain/model/market_place/list_type_nft_collection_explore_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'market_place_res.g.dart';

@JsonSerializable()
class MarketPlaceResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'rows')
  List<ListTypeNftCollectionExploreResponse>? rows;

  MarketPlaceResponse(this.rd, this.rc, this.total, this.rows);

  factory MarketPlaceResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketPlaceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MarketPlaceResponseToJson(this);

  @override
  List<Object?> get props => [];

  List<ListTypeNftCollectionExploreModel>? toDomain() =>
      rows?.map((e) => e.toDomain()).toList();
}
