import 'package:json_annotation/json_annotation.dart';

part 'properties_map_request.g.dart';

@JsonSerializable()
class PropertiesMapRequest {
  final String key;
  final String value;

  PropertiesMapRequest(this.key, this.value);

  factory PropertiesMapRequest.fromJson(Map<String, dynamic> json) =>
      _$PropertiesMapRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesMapRequestToJson(this);
}
