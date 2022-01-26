import 'package:Dfy/data/request/nft/properties_map_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_soft_nft_request.g.dart';

@JsonSerializable()
class CreateSoftNftRequest {
  final String collection_id;
  final String cover_cid;
  final String description;
  final String file_cid;
  final String file_type;
  final int minting_fee_number;
  final String minting_fee_token;
  final String name;
  final String royalties;
  final String txn_hash;
  final List<PropertiesMapRequest> properties;

  CreateSoftNftRequest(
    this.collection_id,
    this.cover_cid,
    this.description,
    this.file_cid,
    this.file_type,
    this.minting_fee_number,
    this.minting_fee_token,
    this.name,
    this.royalties,
    this.txn_hash,
    this.properties,
  );

  factory CreateSoftNftRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSoftNftRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSoftNftRequestToJson(this);
}
