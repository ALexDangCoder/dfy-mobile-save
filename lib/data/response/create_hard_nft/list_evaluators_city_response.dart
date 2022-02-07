import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_evaluators_city_response.g.dart';

@JsonSerializable()
class ListEvaluatorsCityResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'rows')
  List<EvaluatorsResponse>? rows;

  ListEvaluatorsCityResponse(
    this.rd,
    this.rc,
    this.total,
    this.rows,
    this.traceId,
  );

  factory ListEvaluatorsCityResponse.fromJson(Map<String, dynamic> json) =>
      _$ListEvaluatorsCityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListEvaluatorsCityResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class EvaluatorsResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'star_count')
  int? starCount;
  @JsonKey(name: 'reviews_count')
  int? reviewsCount;
  @JsonKey(name: 'evaluated_count')
  int? evaluatedCount;
  @JsonKey(name: 'accepted_asset_type_list')
  List<AcceptedAssetTypeResponse>? acceptedAssetTypeList;
  @JsonKey(name: 'description')
  String? description;

  EvaluatorsResponse(
      this.id,
      this.name,
      this.avatarCid,
      this.starCount,
      this.reviewsCount,
      this.evaluatedCount,
      this.acceptedAssetTypeList,
      this.description,);

  factory EvaluatorsResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluatorsResponseFromJson(json);

  EvaluatorsCityModel toDomain() => EvaluatorsCityModel(
        id: id,
    avatarCid: avatarCid,
    name: name,
    description:description,
    evaluatedCount: evaluatedCount,
    listAcceptedAssetType: acceptedAssetTypeList,
    reviewsCount: reviewsCount,
    starCount: starCount,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class AcceptedAssetTypeResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  AcceptedAssetTypeResponse(
    this.id,
    this.name,
  );

  factory AcceptedAssetTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$AcceptedAssetTypeResponseFromJson(json);

  AcceptedAssetType toDomain() => AcceptedAssetType(
        id: id,
        name: name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
