import 'package:Dfy/data/response/collection_detail/collection_detail_res.dart';
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

  @JsonKey(name: 'rows')
  List<CollectionDetail>? rows;

  DetailCategoryResponse(this.rd, this.rc, this.total, this.rows);

  factory DetailCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailCategoryResponseFromJson(json);


  Map<String, dynamic> toJson() => _$DetailCategoryResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
