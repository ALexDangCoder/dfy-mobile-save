import 'package:Dfy/domain/model/search_marketplace/list_search_collection_nft_model.dart';
import 'package:Dfy/domain/model/search_marketplace/search_collection_nft_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_market_response.g.dart';

@JsonSerializable()
class SearchMarketResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'rows')
  List<ListCollectionFeatNftResponse>? rows;

  SearchMarketResponse(this.rd, this.rc, this.total, this.rows);

  factory SearchMarketResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchMarketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchMarketResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ListCollectionFeatNftResponse extends Equatable {
  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'type')
  String? type;

  @JsonKey(name: 'items')
  List<CollectionFeatNftResponse>? items;

  ListCollectionFeatNftResponse(this.name, this.type, this.items);

  factory ListCollectionFeatNftResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCollectionFeatNftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCollectionFeatNftResponseToJson(this);

  ListSearchCollectionFtNftModel toDomain() => ListSearchCollectionFtNftModel(
        name: name,
        type: type,
        items: items?.map((e) => e.toDomain()).toList() ?? [],
      );

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionFeatNftResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'info')
  String? info;

  @JsonKey(name: 'image_cid')
  String? imageCid;

  @JsonKey(name: 'market_type')
  String? marketType;

  @JsonKey(name: 'file_type')
  String? fileType;

  @JsonKey(name: 'cover_cid')
  String? coverCid;

  CollectionFeatNftResponse(this.id, this.name, this.info, this.imageCid,
      this.marketType, this.fileType, this.coverCid);

  factory CollectionFeatNftResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionFeatNftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionFeatNftResponseToJson(this);

  SearchCollectionNftModel toDomain() => SearchCollectionNftModel(
        id: id ?? '',
        name: name ?? '',
        info: info ?? '',
        imageCid: imageCid ?? '',
        marketType: marketType ?? '',
        fileType: fileType ?? '',
        coverCid: coverCid ?? '',
      );

  @override
  List<Object?> get props => [];
}
