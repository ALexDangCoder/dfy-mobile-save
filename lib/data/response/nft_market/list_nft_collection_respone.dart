
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'nft_collection_response.dart';

part 'list_nft_collection_respone.g.dart';

@JsonSerializable()
class ListNftCollectionResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'rows')
  List<NftCollectionResponse>? rows;


  ListNftCollectionResponse(this.rc, this.rd, this.total, this.rows);

  factory ListNftCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$ListNftCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListNftCollectionResponseToJson(this);

  @override
  List<Object?> get props => [];
  List<NftMarket>? toDomain() => rows?.map((e) => e.toDomain()).toList();
}