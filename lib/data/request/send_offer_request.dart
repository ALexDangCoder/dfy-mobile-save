import 'package:json_annotation/json_annotation.dart';

part 'send_offer_request.g.dart';

@JsonSerializable()
class SendOfferRequest {
  final int bcOfferId;
  final int collateralId;
  final String message;
  final int duration;
  final int durationType;
  final num interestRate;
  final String latestBlockchainTxn;
  final int liquidationThreshold;
  final num loanAmount;
  final num loanToValue;
  final int repaymentCycleType;
  final int pawnShopPackageId;
  final String repaymentToken;
  final String supplyCurrency;
  final String walletAddress;

  SendOfferRequest({
    required this.bcOfferId,
    required this.collateralId,
    required this.message,
    required this.duration,
    required this.durationType,
    required this.interestRate,
    required this.latestBlockchainTxn,
    required this.loanAmount,
    required this.repaymentCycleType,
    required this.walletAddress,
    required this.repaymentToken,
    required this.supplyCurrency,
    required this.liquidationThreshold,
    required this.loanToValue,
    required this.pawnShopPackageId,
  });

  factory SendOfferRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOfferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendOfferRequestToJson(this);
}
