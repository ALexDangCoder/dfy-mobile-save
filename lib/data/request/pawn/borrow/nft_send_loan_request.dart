import 'package:json_annotation/json_annotation.dart';

part 'nft_send_loan_request.g.dart';

@JsonSerializable()
class NftSendLoanRequest {
   String? walletAddress;
   String? nftId;
   String? message;
   double? loanAmount;
   String? loanSymbol;
   int? durationTime;
   int? durationType;
   int? pawnShopPackageId;
   String? collateralSymbol;
   int? collateralId;
   dynamic txId;
   int? marketType;


  NftSendLoanRequest(
      {this.walletAddress,
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
      this.marketType});

  factory NftSendLoanRequest.fromJson(Map<String, dynamic> json) =>
      _$NftSendLoanRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NftSendLoanRequestToJson(this);
}