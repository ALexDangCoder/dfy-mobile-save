import 'package:Dfy/data/request/collection/social_link_map_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_hard_collection_request.g.dart';

@JsonSerializable()
class CreateHardCollectionRequest {
  final String avatar_cid;
  final String bc_txn_hash;
  final String category_id;
  final String category_name;
  final String collection_address;
  final String collection_cid;
  final int collection_type_id;
  final String custom_url;
  final String description;
  final String name;
  final List<SocialLinkMapRequest> social_links;

  CreateHardCollectionRequest({
    required this.avatar_cid,
    required this.bc_txn_hash,
    required this.category_id,
    required this.category_name,
    required this.collection_address,
    required this.collection_cid,
    required this.collection_type_id,
    required this.custom_url,
    required this.description,
    required this.name,
    required this.social_links,
  });

  factory CreateHardCollectionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateHardCollectionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateHardCollectionRequestToJson(this);
}
