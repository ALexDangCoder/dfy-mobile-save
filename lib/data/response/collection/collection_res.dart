import 'package:Dfy/domain/model/market_place/collection_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_res.g.dart';

@JsonSerializable()
class ListCollectionResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'rows')
  List<CollectionResponse>? rows;

  ListCollectionResponse(this.rd, this.rc, this.total, this.rows);

  factory ListCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$ListCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListCollectionResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CollectionResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'total_nft')
  int? totalNft;
  @JsonKey(name: 'nft_owner_count')
  int? nftOwnerCount;
  @JsonKey(name: 'total_volume_traded')
  int? totalVolumeTraded;
  @JsonKey(name: 'is_feature')
  bool? isFeature;

  CollectionResponse(
      this.id,
      this.name,
      this.description,
      this.type,
      this.avatarCid,
      this.coverCid,
      this.totalNft,
      this.nftOwnerCount,
      this.totalVolumeTraded,
      this.isFeature);

  factory CollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$CollectionResponseFromJson(json);

  CollectionModel toDomain() => CollectionModel(
        id: id,
        name: name,
        description: description,
        type: type,
        totalNft: totalNft,
        avatarCid: avatarCid,
        coverCid: coverCid,
        isFeature: isFeature,
        nftOwnerCount: nftOwnerCount,
        totalVolumeTraded: totalVolumeTraded,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
