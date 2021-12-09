import 'package:json_annotation/json_annotation.dart';

part 'app_constants.g.dart';

@JsonSerializable()
class AppConstants {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'base_url')
  String baseUrl;

  @JsonKey(name: 'base_image_url')
  String baseImageUrl;
  @JsonKey(name: 'base_url_test')
  String baseUrlTest;

  AppConstants(
    this.type,
    this.baseUrl,
    this.baseImageUrl,
    this.baseUrlTest,
  );

  factory AppConstants.fromJson(Map<String, dynamic> json) =>
      _$AppConstantsFromJson(json);
}
