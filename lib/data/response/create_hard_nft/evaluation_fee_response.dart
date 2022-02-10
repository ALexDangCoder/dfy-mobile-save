import 'package:Dfy/domain/model/market_place/evaluation_fee.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'evaluation_fee_response.g.dart';

@JsonSerializable()
class EvaluationFeeListResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'rows')
  List<EvaluationFeeResponse>? rows;

  EvaluationFeeListResponse(
    this.rd,
    this.rc,
    this.total,
    this.traceId,
    this.rows,
  );

  factory EvaluationFeeListResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFeeListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluationFeeListResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class EvaluationFeeResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'amount')
  int? amount;
  @JsonKey(name: 'symbol')
  String? symbol;

  EvaluationFeeResponse(
    this.id,
    this.name,
    this.amount,
    this.symbol,
  );

  factory EvaluationFeeResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluationFeeResponseFromJson(json);

  EvaluationFee toDomain() => EvaluationFee(
        amount: amount,
        name: name,
        id: id,
        symbol: symbol,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
