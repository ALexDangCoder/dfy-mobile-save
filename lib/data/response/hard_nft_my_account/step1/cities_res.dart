import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cities_res.g.dart';

@JsonSerializable()
class CitiesResponse extends Equatable {
  @JsonKey(name: 'rc')
  int rc;
  @JsonKey(name: 'rd')
  String rd;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'rows')
  List<CityResponse>? rows;

  CitiesResponse(this.rc, this.rd, this.total, this.rows);

  factory CitiesResponse.fromJson(Map<String, dynamic> json) =>
      _$CitiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CitiesResponseToJson(this);

  List<CityModel>? toDomain() => rows?.map((e) => e.toModel()).toList();

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CityResponse extends Equatable {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'country_id')
  int country_id;
  @JsonKey(name: 'latitude')
  int latitude;
  @JsonKey(name: 'longitude')
  int longitude;

  CityResponse(
      this.id, this.name, this.country_id, this.latitude, this.longitude);

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityResponseToJson(this);

  CityModel toModel() => CityModel(
      id: id,
      name: name,
      countryID: country_id,
      latitude: latitude,
      longitude: longitude);

  @override
  List<Object?> get props => [];
}
