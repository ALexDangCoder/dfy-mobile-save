import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/domain/model/pawn/repayment_stats_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'repayment_stats_response.g.dart';

@JsonSerializable()
class RepaymentStatsResponse {
  @JsonKey(name: 'data')
  DataResponse? data;

  RepaymentStatsResponse(this.data);

  factory RepaymentStatsResponse.fromJson(Map<String, dynamic> json) =>
      _$RepaymentStatsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentStatsResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'totalLoan')
  double? totalLoan;
  @JsonKey(name: 'totalPaid')
  double? totalPaid;
  @JsonKey(name: 'totalUnpaid')
  double? totalUnpaid;

  DataResponse(
    this.totalLoan,
    this.totalPaid,
    this.totalUnpaid,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  RepaymentStatsModel toDomain() => RepaymentStatsModel(
        totalLoan,
        totalPaid,
        totalUnpaid,
      );
}
