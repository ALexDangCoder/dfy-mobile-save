import 'package:json_annotation/json_annotation.dart';

part 'calculate_repayment_fee.g.dart';

@JsonSerializable()
class CalculateRepaymentRequest {
  AmountRequest? interest;
  AmountRequest? loan;
  AmountRequest? penalty;

  CalculateRepaymentRequest({
    this.interest,
    this.loan,
    this.penalty,
  });

  factory CalculateRepaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$CalculateRepaymentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CalculateRepaymentRequestToJson(this);
}

@JsonSerializable()
class AmountRequest {
  double? amount;
  String? address;
  String? symbol;

  AmountRequest({
    this.amount,
    this.address,
    this.symbol,
  });

  factory AmountRequest.fromJson(Map<String, dynamic> json) =>
      _$AmountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AmountRequestToJson(this);
}
