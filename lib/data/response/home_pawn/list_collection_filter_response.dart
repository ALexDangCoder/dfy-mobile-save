import 'package:Dfy/domain/model/market_place/collection_market_model.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_collection_filter_response.g.dart';

@JsonSerializable()
class ListCollectionFilterResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  List<DataResponse>? data;

  ListCollectionFilterResponse(this.code, this.data);

  factory ListCollectionFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCollectionFilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCollectionFilterResponseToJson(this);

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
  @JsonKey(name: 'coverCid')
  String? coverCid;

  DataResponse(
    this.name,
    this.id,
    this.coverCid,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  CollectionMarketModel toDomain() => CollectionMarketModel(
        id: id.toString(),
        name: name,
        coverCid: ApiConstants.BASE_URL_IMAGE + coverCid.toString(),
      );
}
