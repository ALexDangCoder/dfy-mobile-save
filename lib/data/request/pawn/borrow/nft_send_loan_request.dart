import 'package:json_annotation/json_annotation.dart';

part 'nft_send_loan_request.g.dart';

@JsonSerializable()
class NftSendLoanRequest {
  final String walletAddress;
  final String nftId;
  final String message;
  final double loanAmount;
  final String loanSymbol;
  final int durationTime;
  final int durationType;
  final int pawnShopPackageId;
  final String collateralSymbol;
  final int collateralId;
  final dynamic txId;
  final int marketType;


  NftSendLoanRequest(
      this.walletAddress,
      this.nftId,
      this.message,
      this.loanAmount,
      this.loanSymbol,
      this.durationTime,
      this.durationType,
      this.pawnShopPackageId,
      this.collateralSymbol,
      this.collateralId,
      this.txId,
      this.marketType);

  factory NftSendLoanRequest.fromJson(Map<String, dynamic> json) =>
      _$NftSendLoanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NftSendLoanRequestToJson(this);
}