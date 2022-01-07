import 'package:Dfy/data/response/market_place/nft_collection_explore_res.dart';
import 'package:Dfy/domain/model/market_place/list_type_nft_collection_explore_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_type_nft_collection_explore_res.g.dart';

@JsonSerializable()
class ListTypeNftCollectionExploreResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'position')
  int? position;
  @JsonKey(name: 'url')
  String? url;
  @JsonKey(name: 'items')
  List<NftCollectionExploreResponse>? items;

  ListTypeNftCollectionExploreResponse(
    this.id,
    this.name,
    this.type,
    this.position,
    this.url,
    this.items,
  );

  factory ListTypeNftCollectionExploreResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ListTypeNftCollectionExploreResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ListTypeNftCollectionExploreResponseToJson(this);

  ListTypeNftCollectionExploreModel toDomain() =>
      ListTypeNftCollectionExploreModel(
        id: id,
        name: name,
        type: type,
        position: position,
        url: url,
        items: items?.map((e) => e.toDomain()).toList(),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
