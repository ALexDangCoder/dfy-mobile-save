import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_category_res.g.dart';

@JsonSerializable()
class DetailCategoryResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;

  DetailCategoryResponse(
      this.id,
      );


  factory DetailCategoryResponse.fromJson(
      Map<String, dynamic> json) =>
      _$DetailCategoryResponseFromJson(json);


  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}