import 'package:Dfy/data/response/pawn/borrow/nft_on_request_loan_response.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_sent_detail_crypto_collateral_response.g.dart';

@JsonSerializable()
class OfferSentDetailCryptoCollateralTotalResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  dynamic message;

  @JsonKey(name: 'data')
  NftOnRequestLoanContentResponse data;

  @JsonKey(name: 'trace_id')
  String? traceId;

  OfferSentDetailCryptoCollateralTotalResponse(
    this.error,
    this.code,
    this.message,
    this.data,
    this.traceId,
  );

  factory OfferSentDetailCryptoCollateralTotalResponse.fromJson(
          Map<String, dynamic> json) =>
      _$OfferSentDetailCryptoCollateralTotalResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$OfferSentDetailCryptoCollateralTotalResponseToJson(this);

  @override
  List<Object?> get props => [];
}
