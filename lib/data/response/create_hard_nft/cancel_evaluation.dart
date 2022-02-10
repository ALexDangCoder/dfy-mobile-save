import 'package:Dfy/domain/model/market_place/cancel_evaluation_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cancel_evaluation.g.dart';

@JsonSerializable()
class CancelEvaluationResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'item')
  ItemCancelRespone? item;

  CancelEvaluationResponse(
    this.rd,
    this.rc,
    this.item,
  );

  factory CancelEvaluationResponse.fromJson(Map<String, dynamic> json) =>
      _$CancelEvaluationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CancelEvaluationResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ItemCancelRespone extends Equatable {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: '_id')
  String? id;

  ItemCancelRespone(
    this.status,
    this.id,
  );

  factory ItemCancelRespone.fromJson(Map<String, dynamic> json) =>
      _$ItemCancelResponeFromJson(json);

  CancelEvaluationModel toDomain() => CancelEvaluationModel(
        status: status,
        id: id,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
