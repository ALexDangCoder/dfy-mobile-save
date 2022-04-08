import 'package:json_annotation/json_annotation.dart';

part 'send_offer_request.g.dart';

@JsonSerializable()
class SendOfferRequest {
  final int? bcOfferId;
  final int? collateralId;
  final String? message;
  final int? duration;
  final int? durationType;
  final String? interestRate;
  final int? liquidationThreshold;
  final num? loanAmount;
  final num? loanToValue;
  final num? loanRequestId;
  final int? pawnShopPackageId;
  final String? repaymentToken;
  final String? supplyCurrency;
  final String? latestBlockchainTxn;
  final String? walletAddress;

  SendOfferRequest(
      this.bcOfferId,
      this.collateralId,
      this.message,
      this.duration,
      this.durationType,
      this.interestRate,
      this.liquidationThreshold,
      this.loanAmount,
      this.loanToValue,
      this.loanRequestId,
      this.pawnShopPackageId,
      this.repaymentToken,
      this.supplyCurrency,
      this.latestBlockchainTxn,
      this.walletAddress);

  factory SendOfferRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOfferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendOfferRequestToJson(this);
}
