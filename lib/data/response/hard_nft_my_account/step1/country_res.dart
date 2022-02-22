import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_res.g.dart';

@JsonSerializable()
class ListCountryResponse extends Equatable {
  @JsonKey(name: 'rc')
  int rc;
  @JsonKey(name: 'rd')
  String rd;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'rows')
  List<CountryResponse>? rows;

  ListCountryResponse(this.rc, this.rd, this.total, this.rows);

  factory ListCountryResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCountryResponseToJson(this);

  List<CountryModel>? toDomain() => rows?.map((e) => e.toModel()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class CountryResponse extends Equatable {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;

  CountryResponse(this.id, this.name);

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      _$CountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountryResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];

  CountryModel toModel() => CountryModel(
        id: id.toString(),
        name: name,
      );
}
