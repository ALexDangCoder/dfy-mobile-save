import 'package:json_annotation/json_annotation.dart';

part 'create_hard_nft_ipfs_request.g.dart';

@JsonSerializable()
class CreateHardNftIpfsRequest {
  List<AdditionalInfoListRequest>? additional_info_list;
  String? additional_information;
  String? name;
  int? asset_type_id;
  int? condition_id;
  String? contact_address;
  int? contact_city_id;
  String? contact_country_id;
  String? contact_email;
  String? contact_name;
  String? contact_phone;
  String? contact_phone_code_id;
  List<DocumentFeatMediaListRequest>? document_list;
  double? expecting_price;
  String? expecting_price_symbol;
  List<DocumentFeatMediaListRequest>? media_list;
  String? bc_txn_hash;
  String? collection_address;

  CreateHardNftIpfsRequest({
    this.additional_info_list,
    this.additional_information,
    this.name,
    this.asset_type_id,
    this.condition_id,
    this.contact_address,
    this.contact_city_id,
    this.contact_country_id,
    this.contact_email,
    this.contact_name,
    this.contact_phone,
    this.contact_phone_code_id,
    this.document_list,
    this.expecting_price,
    this.expecting_price_symbol,
    this.media_list,
    this.bc_txn_hash,
    this.collection_address,
  });

  factory CreateHardNftIpfsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateHardNftIpfsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateHardNftIpfsRequestToJson(this);
}

@JsonSerializable()
class AdditionalInfoListRequest {
  final String trait_type;
  final String value;

  AdditionalInfoListRequest({
    required this.trait_type,
    required this.value,
  });

  factory AdditionalInfoListRequest.fromJson(Map<String, dynamic> json) =>
      _$AdditionalInfoListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AdditionalInfoListRequestToJson(this);
}

@JsonSerializable()
class DocumentFeatMediaListRequest {
  String name;
  String type;
  String cid;

  DocumentFeatMediaListRequest({
    required this.name,
    required this.type,
    required this.cid,
  });

  factory DocumentFeatMediaListRequest.fromJson(Map<String, dynamic> json) =>
      _$DocumentFeatMediaListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentFeatMediaListRequestToJson(this);
}
