import 'package:Dfy/domain/model/pawn/borrow/nft_res_after_post_rq_loan_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_res_after_post_request_loan.g.dart';

@JsonSerializable()
class NftResAfterPostLoanRequestResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  dynamic message;

  @JsonKey(name: 'data')
  dynamic data;

  @JsonKey(name: 'trace_id')
  dynamic traceId;

  NftResAfterPostLoanRequestResponse(
      this.error, this.code, this.message, this.data, this.traceId);

  factory NftResAfterPostLoanRequestResponse.fromJson(
          Map<String, dynamic> json) =>
      _$NftResAfterPostLoanRequestResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$NftResAfterPostLoanRequestResponseToJson(this);

  NftResAfterPostRqLoanModel toModel() => NftResAfterPostRqLoanModel(
        code: code,
        err: error,
        traceId: traceId,
      );

  @override
  List<Object?> get props => [];
}
