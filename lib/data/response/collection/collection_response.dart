

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'collection_response.g.dart';

@JsonSerializable()
class CollectionRespone extends Equatable {
  @JsonKey(name: 'avatarBack')
  String avatarBack;
  @JsonKey(name: 'avatarIcon')
  String avatarIcon;
  @JsonKey(name: 'item')
  int item;
  @JsonKey(name: 'owners')
  int owners;
  @JsonKey(name: 'title')
  String title;
  @JsonKey(name: 'textbody')
  String textbody;
  @JsonKey(name: 'volume')
  int volume;
  @JsonKey(name: 'owner')
  String owner;
  @JsonKey(name: 'contract')
  String contract;
  @JsonKey(name: 'nftstandard')
  String nftstandard;
  @JsonKey(name: 'category')
  String category;
  @JsonKey(name: 'id')
  String id;

  CollectionRespone(
    this.avatarBack,
    this.avatarIcon,
    this.item,
    this.owners,
    this.title,
    this.textbody,
    this.volume,
    this.owner,
    this.contract,
    this.nftstandard,
    this.category,
    this.id,
  );

  factory CollectionRespone.fromJson(Map<String, dynamic> json) =>
      _$CollectionResponeFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionResponeToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
