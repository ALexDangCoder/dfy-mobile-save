import 'package:json_annotation/json_annotation.dart';

part 'put_on_auction_request.g.dart';

@JsonSerializable()
class PutOnAuctionRequest {
  final String nft_id;
  final String token;
  final String txn_hash;
  final int buy_out_price;
  final int end_time;
  final int nft_type;
  final int price_step;
  final int reserve_price;
  final int start_time;
  final bool enable_buy_out_price;
  final bool enable_price_step;
  final bool get_email;

  PutOnAuctionRequest({
    required this.nft_id,
    required this.token,
    required this.txn_hash,
    required this.nft_type,
    required this.buy_out_price,
    required this.end_time,
    required this.price_step,
    required this.reserve_price,
    required this.start_time,
    required this.enable_buy_out_price,
    required this.enable_price_step,
    required this.get_email,
  });

  factory PutOnAuctionRequest.fromJson(Map<String, dynamic> json) =>
      _$PutOnAuctionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PutOnAuctionRequestToJson(this);
}
