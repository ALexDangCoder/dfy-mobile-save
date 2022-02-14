import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'confirm_evaluation_response.g.dart';

@JsonSerializable()
class ConfirmEvaluationResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'code')
  String? code;

  ConfirmEvaluationResponse(
      this.rd,
      this.rc,
      this.code,
      );

  factory ConfirmEvaluationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConfirmEvaluationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmEvaluationResponseToJson(this);

  @override
  List<Object?> get props => [];


}
