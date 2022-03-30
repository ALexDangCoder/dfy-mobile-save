import 'package:json_annotation/json_annotation.dart';

part 'repayment_pay_request.g.dart';

@JsonSerializable()
class RepaymentPayRequest {
  AmountRequest? interest;
  AmountRequest? loan;
  AmountRequest? penalty;

  RepaymentPayRequest({
    this.interest,
    this.loan,
    this.penalty,
  });

  factory RepaymentPayRequest.fromJson(Map<String, dynamic> json) =>
      _$RepaymentPayRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RepaymentPayRequestToJson(this);
}

@JsonSerializable()
class AmountRequest {
  double? amount;

  AmountRequest({
    this.amount,
  });

  factory AmountRequest.fromJson(Map<String, dynamic> json) =>
      _$AmountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AmountRequestToJson(this);
}
