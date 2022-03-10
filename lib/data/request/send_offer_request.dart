import 'package:json_annotation/json_annotation.dart';

part 'send_offer_request.g.dart';

@JsonSerializable()
class SendOfferRequest {
  final int cryptoCollateralId;
  final String description;
  final int durationQty;
  final int durationType;
  final num interestRate;
  final int liquidationThreshold;
  final num loanAmount;
  final num loanToValue;
  final int repaymentCycleType;
  final String repaymentTokenSymbol;
  final String supplyCurrency;
  final String txid;
  final String walletAddress;

  SendOfferRequest(
      this.cryptoCollateralId,
      this.description,
      this.durationQty,
      this.durationType,
      this.interestRate,
      this.liquidationThreshold,
      this.loanAmount,
      this.loanToValue,
      this.repaymentCycleType,
      this.supplyCurrency,
      this.repaymentTokenSymbol,
      this.txid,
      this.walletAddress);

  factory SendOfferRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOfferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendOfferRequestToJson(this);
}
