import 'package:Dfy/data/response/collection_filter/collection_filter_response.dart';
import 'package:Dfy/domain/model/collection_filter.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_response_call_api.g.dart';

@JsonSerializable()
class ListResponseFromApi extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'rows')
  List<CollectionFilterResponse>? rows;

  ListResponseFromApi(this.rc, this.rd, this.total, this.rows);

  factory ListResponseFromApi.fromJson(Map<String, dynamic> json) =>
      _$ListResponseFromApiFromJson(json);

  Map<String, dynamic> toJson() => _$ListResponseFromApiToJson(this);

  @override
  List<Object?> get props => [];

  List<CollectionFilter>? toDomain() => rows?.map((e) => e.toDomain()).toList();
}
