import 'package:json_annotation/json_annotation.dart';

part 'app_constants.g.dart';

@JsonSerializable()
class AppConstants {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'base_url')
  String baseUrl;

  @JsonKey(name: 'base_url_pinata')
  String baseUrlPinata;

  @JsonKey(name: 'base_custom_url')
  String baseCustomUrl;

  @JsonKey(name: 'base_image_url')
  String baseImageUrl;

  @JsonKey(name: 'rpc_url')
  String rpcUrl;

  @JsonKey(name: 'chain_id')
  String chaninId;

  @JsonKey(name: 'bsc_scan')
  String bscScan;

  AppConstants(
    this.type,
    this.baseUrl,
    this.baseUrlPinata,
    this.baseCustomUrl,
    this.baseImageUrl,
    this.rpcUrl,
    this.chaninId,
    this.bscScan,
  );

  factory AppConstants.fromJson(Map<String, dynamic> json) =>
      _$AppConstantsFromJson(json);
}
