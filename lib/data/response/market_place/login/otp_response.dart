import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/otp_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

@JsonSerializable()
class OTPResponse extends Equatable {
  @JsonKey(name: 'transaction_id')
  String? transactionId;
  @JsonKey(name: 'expired_seconds')
  int? expiredSeconds;
  @JsonKey(name: 'failed_count')
  int? failedCount;
  @JsonKey(name: 'failed_limit')
  int? failedLimit;
  @JsonKey(name: 'tx_failed_count')
  int? txFailedCount;
  @JsonKey(name: 'tx_failed_limit')
  int? txFailedLimit;

  OTPResponse();

  factory OTPResponse.fromJson(Map<String, dynamic> json) =>
      _$OTPResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OTPResponseToJson(this);

  OTPModel toDomain() => OTPModel(
        expiredSeconds: expiredSeconds,
        failedCount: failedCount,
        failedLimit: failedLimit,
        transactionId: transactionId,
        txFailedCount: txFailedCount,
        txFailedLimit: txFailedLimit,
      );

  @override
  List<Object?> get props => [];
}
