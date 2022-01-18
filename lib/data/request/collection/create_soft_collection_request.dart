import 'package:Dfy/data/request/collection/social_link_map_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_soft_collection_request.g.dart';

@JsonSerializable()
class CreateSoftCollectionRequest {
  final String avatar_cid;
  final String category_id;
  final String collection_standard;
  final String cover_cid;
  final String custom_url;
  final String description;
  final String feature_cid;
  final String name;
  final String royalty;
  final String txn_hash;
  final List<SocialLinkMapRequest> social_links;

  CreateSoftCollectionRequest({
    required this.avatar_cid,
    required this.category_id,
    required this.collection_standard,
    required this.cover_cid,
    required this.custom_url,
    required this.description,
    required this.feature_cid,
    required this.name,
    required this.royalty,
    required this.txn_hash,
    required this.social_links,
  });

  factory CreateSoftCollectionRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSoftCollectionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSoftCollectionRequestToJson(this);
}
