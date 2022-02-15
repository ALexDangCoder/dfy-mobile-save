import 'package:Dfy/data/request/nft/properties_map_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_soft_nft_ipfs_request.g.dart';

@JsonSerializable()
class CreateSoftNftIpfsRequest {
  String collection_id = '';
  String cover_cid = '';
  String description = '';
  String file_cid = '';
  String file_type = '';
  String minting_fee_number = '';
  String minting_fee_token = '';
  String name = '';
  String royalties = '';
  List<PropertiesMapRequest> properties = [];

  CreateSoftNftIpfsRequest({
    required this.collection_id,
    required this.cover_cid,
    required this.description,
    required this.file_cid,
    required this.file_type,
    required this.minting_fee_number,
    required this.minting_fee_token,
    required this.name,
    required this.royalties,
    required this.properties,
  });

  CreateSoftNftIpfsRequest.init();

  factory CreateSoftNftIpfsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSoftNftIpfsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSoftNftIpfsRequestToJson(this);
}
