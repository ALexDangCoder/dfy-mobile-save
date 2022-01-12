import 'package:Dfy/domain/model/market_place/collection_detail_filter_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_detail_filter_response.g.dart';

@JsonSerializable()
class CollectionDetailFilterResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'rows')
  List<CollectionFilterDetail>? rows;

  CollectionDetailFilterResponse(
    this.rd,
    this.rc,
    this.traceId,
    this.rows,
  );

  factory CollectionDetailFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionDetailFilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionDetailFilterResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionFilterDetail {
  @JsonKey(name: 'key')
  String? key;
  @JsonKey(name: 'values')
  List<String>? values;

  CollectionFilterDetail(
    this.key,
    this.values,
  );

  factory CollectionFilterDetail.fromJson(Map<String, dynamic> json) =>
      _$CollectionFilterDetailFromJson(json);

  CollectionFilterDetailModel toDomain() => CollectionFilterDetailModel(
        key,
        values,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
