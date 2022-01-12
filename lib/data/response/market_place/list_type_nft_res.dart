import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_type_nft_res.g.dart';

@JsonSerializable()
class ListTypeNFTResponse extends Equatable {
  @JsonKey(name: 'rc')
  int rc;
  @JsonKey(name: 'rd')
  String rd;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'trace-id')
  String traceId;
  @JsonKey(name: 'rows')
  List<TypeNFTResponse>? rows;

  ListTypeNFTResponse(
    this.rc,
    this.rd,
    this.total,
    this.traceId,
    this.rows,
  );

  factory ListTypeNFTResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTypeNFTResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListTypeNFTResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class TypeNFTResponse extends Equatable {
  @JsonKey(name: 'id')
  String id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'type')
  int type;
  @JsonKey(name: 'standard')
  int standard;

  TypeNFTResponse(
    this.id,
    this.name,
    this.description,
    this.type,
    this.standard,
  );

  factory TypeNFTResponse.fromJson(Map<String, dynamic> json) =>
      _$TypeNFTResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TypeNFTResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];

  TypeNFTModel toModel() => TypeNFTModel(
        id,
        name,
        description,
        type,
        standard,
      );
}
