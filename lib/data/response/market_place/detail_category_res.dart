import 'package:Dfy/data/response/collection_detail/collection_detail_response.dart';
import 'package:Dfy/domain/model/market_place/collection_categories_model.dart';
import 'package:Dfy/domain/model/market_place/list_collection_detail_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_category_res.g.dart';

@JsonSerializable()
class DetailCategoryResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'rows')
  List<ListCollectionCategoryResponse>? rows;

  DetailCategoryResponse(this.rd, this.rc, this.total, this.rows, this.traceId);

  factory DetailCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailCategoryResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ListCollectionDetailModel toDomain() {
    return ListCollectionDetailModel(
      listData: rows?.map((e) => e.toDomain()).toList() ?? [],
      total: total ?? 0,
    );
  }
}

@JsonSerializable()
class ListCollectionCategoryResponse extends Equatable {
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'collection_name')
  String? collectionName;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'collection_type')
  int? collectionType;
  @JsonKey(name: 'nft_owner_count')
  int? nftOwnerCount;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'feature_cid')
  String? featureCid;
  @JsonKey(name: 'is_whitelist')
  bool? isWhiteList;
  @JsonKey(name: 'total_nft')
  int? totalNft;

  ListCollectionCategoryResponse(
    this.id,
    this.collectionName,
    this.nftOwnerCount,
    this.description,
    this.collectionType,
    this.avatarCid,
    this.coverCid,
    this.featureCid,
    this.totalNft,
    this.isWhiteList,
  );

  factory ListCollectionCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCollectionCategoryResponseFromJson(json);

  CollectionCategoryModel toDomain() => CollectionCategoryModel(
        avatarId: avatarCid,
        collectionName: collectionName,
        collectionType: collectionType,
        coverId: coverCid,
        description: description,
        featureId: featureCid,
        id: id,
        isWhiteList: isWhiteList,
        nftOwnerCount: nftOwnerCount,
        totalNft: totalNft,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
