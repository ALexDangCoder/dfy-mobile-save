import 'package:json_annotation/json_annotation.dart';

part 'put_on_auction_resquest.g.dart';

@JsonSerializable()
class PutOnAuctionRequest {
  final int buy_out_price;
  final bool enable_buy_out_price;
  final bool enable_price_step;
  final int end_time;
  final int start_time;
  final bool get_email;
  final String nft_id;
  final int nft_type;
  final String token;
  final String txn_hash;
  final int price_step;
  final int reserve_price;

  PutOnAuctionRequest({
    required this.nft_id,
    required this.token,
    required this.txn_hash,
    required this.nft_type,
    required this.buy_out_price,
    required this.enable_buy_out_price,
    required this.enable_price_step,
    required this.end_time,
    required this.start_time,
    required this.get_email,
    required this.price_step,
    required this.reserve_price,
  });

  factory PutOnAuctionRequest.fromJson(Map<String, dynamic> json) =>
      _$PutOnAuctionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PutOnAuctionRequestToJson(this);
}
