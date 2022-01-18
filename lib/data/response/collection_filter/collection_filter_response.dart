import 'package:Dfy/domain/model/collection_filter.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_filter_response.g.dart';

@JsonSerializable()
class CollectionFilterResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'owner')
  String? owner;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;

  CollectionFilterResponse(
    this.id,
    this.name,
    this.owner,
    this.avatarCid,
  );

  factory CollectionFilterResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionFilterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionFilterResponseToJson(this);

  @override
  List<Object?> get props => [];

  String getPath() {
    return ApiConstants.BASE_URL_IMAGE + (avatarCid ?? '');
  }

  CollectionFilter toDomain() => CollectionFilter(
        name: name ?? '',
        avatarCid: getPath(),
        id: id ?? '',
      );
}
