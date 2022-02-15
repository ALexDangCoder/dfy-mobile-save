import 'package:Dfy/data/request/create_hard_nft/create_hard_nft_ipfs_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_hard_nft_assets_request.g.dart';

@JsonSerializable()
class CreateHardNftAssetsRequest {
  final List<AdditionalInfoListRequest> additional_info_list;
  final String additional_information;
  final String name;
  final int asset_type_id;
  final int condition_id;
  final String contact_address;
  final int contact_city_id;
  final String contact_country_id;
  final String contact_email;
  final String contact_name;
  final String contact_phone;
  final String contact_phone_code_id;
  final List<DocumentFeatMediaListRequest> document_list;
  final double expecting_price;
  final String expecting_price_symbol;
  final List<DocumentFeatMediaListRequest> media_list;
  final String bc_txn_hash;
  final String asset_cid;

  CreateHardNftAssetsRequest({
    required this.additional_info_list,
    required this.additional_information,
    required this.name,
    required this.asset_type_id,
    required this.condition_id,
    required this.contact_address,
    required this.contact_city_id,
    required this.contact_country_id,
    required this.contact_email,
    required this.contact_name,
    required this.contact_phone,
    required this.contact_phone_code_id,
    required this.document_list,
    required this.expecting_price,
    required this.expecting_price_symbol,
    required this.media_list,
    required this.bc_txn_hash,
    required this.asset_cid,
  });

  factory CreateHardNftAssetsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateHardNftAssetsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateHardNftAssetsRequestToJson(this);
}
