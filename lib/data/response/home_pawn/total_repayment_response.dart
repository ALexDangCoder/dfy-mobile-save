import 'package:Dfy/domain/model/home_pawn/total_repaymnent_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'total_repayment_response.g.dart';

@JsonSerializable()
class TotalRepaymentResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  TotalRepaymentResponse(this.data);

  factory TotalRepaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$TotalRepaymentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TotalRepaymentResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'symbolLoan')
  String? symbolLoan;
  @JsonKey(name: 'totalLoan')
  double? totalLoan;
  @JsonKey(name: 'symbolInterest')
  String? symbolInterest;
  @JsonKey(name: 'totalInterest')
  double? totalInterest;
  @JsonKey(name: 'symbolPenalty')
  String? symbolPenalty;
  @JsonKey(name: 'totalPenalty')
  double? totalPenalty;

  DataResponse(
    this.symbolLoan,
    this.totalLoan,
    this.symbolInterest,
    this.totalInterest,
    this.symbolPenalty,
    this.totalPenalty,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  TotalRepaymentModel toDomain() => TotalRepaymentModel(
        symbolLoan,
        totalLoan,
        symbolInterest,
        totalInterest,
        symbolPenalty,
        totalPenalty,
      );
}
