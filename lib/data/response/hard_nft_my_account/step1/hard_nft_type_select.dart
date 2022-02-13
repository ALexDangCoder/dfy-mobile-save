import 'package:Dfy/domain/model/hard_nft_my_account/step1/hard_nft_type_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hard_nft_type_select.g.dart';

@JsonSerializable()
class ListHardNFTTypeResponse extends Equatable {
  @JsonKey(name: 'rc')
  int rc;
  @JsonKey(name: 'rd')
  String rd;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'rows')
  List<HardNftTypeResponse>? rows;
  @JsonKey(name: 'trace-id')
  String traceId;

  ListHardNFTTypeResponse(
    this.rc,
    this.rd,
    this.total,
    this.rows,
    this.traceId,
  );

  factory ListHardNFTTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$ListHardNFTTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListHardNFTTypeResponseToJson(this);

  List<HardNftTypeModel>? toDomain() => rows?.map((e) => e.toModel()).toList();

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class HardNftTypeResponse extends Equatable {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;

  HardNftTypeResponse(this.id, this.name);

  factory HardNftTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$HardNftTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HardNftTypeResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  HardNftTypeModel toModel() => HardNftTypeModel(
        id : id,
        name: name,
        isSelected: false,
      );
}
