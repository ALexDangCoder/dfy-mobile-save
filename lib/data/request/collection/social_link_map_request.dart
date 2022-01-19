import 'package:json_annotation/json_annotation.dart';

part 'social_link_map_request.g.dart';

@JsonSerializable()
class SocialLinkMapRequest {
  final String type;
  final String url;

  SocialLinkMapRequest(this.type, this.url);

  factory SocialLinkMapRequest.fromJson(Map<String, dynamic> json) =>
      _$SocialLinkMapRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SocialLinkMapRequestToJson(this);
}
