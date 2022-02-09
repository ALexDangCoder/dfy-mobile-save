import 'package:Dfy/domain/model/market_place/evaluation_result.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'evaluation_result.g.dart';

@JsonSerializable()
class EvaluationResultResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'rows')
  List<EvaluationResponse>? item;

  EvaluationResultResponse(
    this.rd,
    this.rc,
    this.item,
  );

  factory EvaluationResultResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluationResultResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationResultResponseToJson(this);

  @override
  List<Object?> get props => [];
  List<EvaluationResult>? toDomain() => item?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class EvaluationResponse extends Equatable {
  @JsonKey(name: 'id')
  String? evaluationId;
  @JsonKey(name: 'evaluator')
  EvaluatorResponse? avatarEvaluator;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'evaluated_price')
  num? evaluatedPrice;
  @JsonKey(name: 'evaluated_price_symbol')
  String? evaluatedSymbol;

  EvaluationResponse(
    this.evaluationId,
    this.avatarEvaluator,
    this.status,
    this.evaluatedPrice,
    this.evaluatedSymbol,
  );

  factory EvaluationResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];

  String getPath(String avatarCid) {
    return ApiConstants.BASE_URL_IMAGE + avatarCid;
  }

  EvaluationResult toDomain() => EvaluationResult(
        evaluationId: evaluationId,
        avatarEvaluator: getPath(avatarEvaluator?.avatarCid ?? ''),
        status: status,
        evaluatedSymbol: evaluatedSymbol,
        evaluatedPrice: evaluatedPrice,
      );
}

@JsonSerializable()
class EvaluatorResponse extends Equatable {

  @JsonKey(name: 'avatar_cid')
  String? avatarCid;

  EvaluatorResponse(this.avatarCid);

  factory EvaluatorResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluatorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluatorResponseToJson(this);

  @override
  List<Object?> get props => [];

}
