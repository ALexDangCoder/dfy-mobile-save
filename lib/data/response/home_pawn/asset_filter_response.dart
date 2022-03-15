import 'package:Dfy/domain/model/home_pawn/asset_filter_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'asset_filter_response.g.dart';

@JsonSerializable()
class AssetFilterResponse extends Equatable {
  @JsonKey(name: 'data')
  List<DataResponse>? data;

  AssetFilterResponse( this.data);

  factory AssetFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetFilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetFilterResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'id')
  int? id;

  DataResponse(
    this.name,
    this.id,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  AssetFilterModel toDomain() => AssetFilterModel(
        id: id,
        name: name,
      );
}
