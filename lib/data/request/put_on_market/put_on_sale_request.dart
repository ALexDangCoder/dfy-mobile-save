import 'package:json_annotation/json_annotation.dart';

part 'put_on_sale_request.g.dart';

@JsonSerializable()
class PutOnSaleRequest {
  final String nft_id;
  final String token;
  final String txn_hash;
  final int nft_type;
  final int number_of_copies;
  final int price;

  PutOnSaleRequest({
    required this.nft_id,
    required this.token,
    required this.txn_hash,
    required this.nft_type,
    required this.number_of_copies,
    required this.price,
  });

  factory PutOnSaleRequest.fromJson(Map<String, dynamic> json) =>
      _$PutOnSaleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PutOnSaleRequestToJson(this);
}
