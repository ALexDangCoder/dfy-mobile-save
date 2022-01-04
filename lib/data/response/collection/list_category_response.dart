import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_category_response.g.dart';

@JsonSerializable()
class ListCategoryResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'rows')
  List<CategoryResponse>? rows;

  ListCategoryResponse(this.rc, this.rd, this.total, this.rows);

  factory ListCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ListCategoryResponseToJson(this);
  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CategoryResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'banner_cid')
  String? bannerCid;
  @JsonKey(name: 'create_at')
  double? createAt;
  @JsonKey(name: 'update_at')
  double? updateAt;
  @JsonKey(name: 'total_collection')
  int? totalCollection;

  CategoryResponse(this.id, this.name, this.description, this.avatarCid,
      this.bannerCid, this.createAt, this.updateAt, this.totalCollection);


  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
  Category toDomain() => Category(
        id,
        name,
        description,
        avatarCid,
        bannerCid,
        createAt,
        updateAt,
        totalCollection,
      );
}
