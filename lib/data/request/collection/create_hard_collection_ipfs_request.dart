import 'package:Dfy/data/request/collection/social_link_map_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_hard_collection_ipfs_request.g.dart';

@JsonSerializable()
class CreateHardCollectionIpfsRequest {
  String avatar_cid = '';
  String category_name = '';
  String cover_cid = '';
  String custom_url = '';
  String description = '';
  String external_link = '';
  String feature_cid = '';
  String image = '';
  String name = '';
  int standard = 0;
  int type = 1;
  List<SocialLinkMapRequest> social_links = [];

  CreateHardCollectionIpfsRequest({
    required this.external_link,
    required this.feature_cid,
    required this.image,
    required this.name,
    required this.custom_url,
    required this.avatar_cid,
    required this.category_name,
    required this.cover_cid,
    required this.social_links,
    required this.description,
    required this.type,
    required this.standard,
  });

  CreateHardCollectionIpfsRequest.init();

  factory CreateHardCollectionIpfsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateHardCollectionIpfsRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CreateHardCollectionIpfsRequestToJson(this);
}
