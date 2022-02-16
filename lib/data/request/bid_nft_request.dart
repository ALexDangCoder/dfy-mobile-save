import 'package:json_annotation/json_annotation.dart';

part 'bid_nft_request.g.dart';

@JsonSerializable()
class BidNftRequest {
  final String market_id;
  final double bid_value;
  final String txn_hash;

  BidNftRequest(this.market_id, this.bid_value, this.txn_hash);

  factory BidNftRequest.fromJson(Map<String, dynamic> json) =>
      _$BidNftRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BidNftRequestToJson(this);
}
