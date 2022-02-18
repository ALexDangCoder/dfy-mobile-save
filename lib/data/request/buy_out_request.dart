import 'package:json_annotation/json_annotation.dart';

part 'buy_out_request.g.dart';

@JsonSerializable()
class BuyOutRequest {
  final String auction_id;
  final String txn_hash;

  BuyOutRequest(this.auction_id, this.txn_hash);

  factory BuyOutRequest.fromJson(Map<String, dynamic> json) =>
      _$BuyOutRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BuyOutRequestToJson(this);
}
