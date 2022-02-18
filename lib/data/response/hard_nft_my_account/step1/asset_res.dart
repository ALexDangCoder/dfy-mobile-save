import 'package:Dfy/domain/model/hard_nft_my_account/step1/asset_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'asset_res.g.dart';
@JsonSerializable()
class AssetResponse extends Equatable {

  @JsonKey(name: 'rc')
  int rc;
  @JsonKey(name: 'rd')
  String rd;
  @JsonKey(name: 'item')
  AssetItemResponse item;

  AssetModel toModel() => item.toModel();

  AssetResponse(this.rc, this.rd, this.item);

  factory AssetResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetResponseToJson(this);


  @override
  List<Object?> get props => [];

}

@JsonSerializable()
class AssetItemResponse extends Equatable {

  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'status')
  int status;


  AssetItemResponse(this.id, this.status);

  factory AssetItemResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AssetItemResponseToJson(this);

  AssetModel toModel() => AssetModel(id, status);

  @override
  List<Object?> get props => [];
}
