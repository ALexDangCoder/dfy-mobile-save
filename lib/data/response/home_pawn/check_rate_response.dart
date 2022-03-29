import 'package:Dfy/domain/model/home_pawn/check_rate_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_rate_response.g.dart';

@JsonSerializable()
class CheckRateResponse {
  @JsonKey(name: 'data')
  DataResponse? data;

  CheckRateResponse(this.data);

  factory CheckRateResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckRateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckRateResponseToJson(this);
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'isReview')
  bool? isReview;
  @JsonKey(name: 'isShow')
  bool? isShow;

  DataResponse(
    this.isReview,
    this.isShow,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  CheckRateModel toDomain() => CheckRateModel(
        isReview,
        isShow,
      );
}
