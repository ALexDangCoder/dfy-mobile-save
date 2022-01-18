import 'package:json_annotation/json_annotation.dart';

part 'buy_nft_request.g.dart';

@JsonSerializable()
class BuyNftRequest {
  final String nft_market_id;
  final int quantity;
  final String txn_hash;

  BuyNftRequest(this.nft_market_id, this.quantity, this.txn_hash);

  factory BuyNftRequest.fromJson(Map<String, dynamic> json) =>
      _$BuyNftRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BuyNftRequestToJson(this);
}
