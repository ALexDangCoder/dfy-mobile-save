import 'package:Dfy/data/request/collection/social_link_map_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_collection_ipfs_request.g.dart';

@JsonSerializable()
class CreateCollectionIpfsRequest {
  String external_link = '';
  String feature_cid = '';
  String image = '';
  String name = '';
  String custom_url = '';
  String avatar_cid = '';
  String category = '';
  String cover_cid = '';
  List<SocialLinkMapRequest> social_links = [];

  CreateCollectionIpfsRequest({
    required this.external_link,
    required this.feature_cid,
    required this.image,
    required this.name,
    required this.custom_url,
    required this.avatar_cid,
    required this.category,
    required this.cover_cid,
    required this.social_links,
  });

  CreateCollectionIpfsRequest.init();

  factory CreateCollectionIpfsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateCollectionIpfsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateCollectionIpfsRequestToJson(this);
}
