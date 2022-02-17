import 'package:Dfy/data/request/collection/social_link_map_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_soft_collection_ipfs_request.g.dart';

@JsonSerializable()
class CreateSoftCollectionIpfsRequest {
  String external_link = '';
  String feature_cid = '';
  String image = '';
  String name = '';
  String custom_url = '';
  String avatar_cid = '';
  String category = '';
  String cover_cid = '';
  String description = '';
  List<SocialLinkMapRequest> social_links = [];

  CreateSoftCollectionIpfsRequest({
    required this.external_link,
    required this.feature_cid,
    required this.image,
    required this.name,
    required this.custom_url,
    required this.avatar_cid,
    required this.category,
    required this.cover_cid,
    required this.social_links,
    required this.description,
  });

  CreateSoftCollectionIpfsRequest.init();

  factory CreateSoftCollectionIpfsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateSoftCollectionIpfsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateSoftCollectionIpfsRequestToJson(this);
}
