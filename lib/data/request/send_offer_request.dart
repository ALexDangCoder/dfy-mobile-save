import 'package:json_annotation/json_annotation.dart';

part 'send_offer_request.g.dart';

// bcOfferId	integer($int64)
// Blockchain Offer Id
// collateralId	integer($int64)
// Collateral Id
// duration	integer
// If choose “weeks” its mean maximum = 5200. If not valid, the system will warning “Duration by day can not greater than 5200”
// If choose “months” its mean maximum = 1200. If not valid, the system will warning “Duration by month can not greater than 1200”
//
// durationType	integer($int32)
// Duration type: 0 => Week, 1 => Month
//
// interestRate	number
// latestBlockchainTxn	string
// Blockchain Txn Id
// liquidationThreshold	number
// loanAmount	number
// loanToValue	number
// message	string
// Message
// pawnShopPackageId	integer($int64)
// PawnShop package Id
// repaymentToken	string
// Default is "DFY". Another option is the Loan token
//
// supplyCurrency	string
// walletAddress	string
// Wallet Address

@JsonSerializable()
class SendOfferRequest {
  final int bcOfferId = 0;
  final int collateralId;
  final String message;
  final int duration;
  final int durationType;
  final num interestRate;
  String? _latestBlockchainTxn;
  final int liquidationThreshold = 0;
  final num loanAmount;
  final num loanToValue = 0;
  final int repaymentCycleType;
  final int pawnShopPackageId = 0;
  final String repaymentToken;
  final String supplyCurrency;
  final String walletAddress;

  set latestBlockchainTxn(String value) {
    _latestBlockchainTxn = value;
  }

  SendOfferRequest({
    required this.collateralId,
    required this.message,
    required this.duration,
    required this.durationType,
    required this.interestRate,
    required this.loanAmount,
    required this.repaymentCycleType,
    required this.walletAddress,
    required this.repaymentToken,
    required this.supplyCurrency,
  });

  factory SendOfferRequest.fromJson(Map<String, dynamic> json) =>
      _$SendOfferRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendOfferRequestToJson(this);
}
