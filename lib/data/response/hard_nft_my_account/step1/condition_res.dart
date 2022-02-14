import 'package:Dfy/domain/model/hard_nft_my_account/step1/condition_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'condition_res.g.dart';

@JsonSerializable()
class ListConditionResponse extends Equatable {
  @JsonKey(name: 'rc')
  int rc;
  @JsonKey(name: 'rd')
  String rd;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'rows')
  List<ConditionResponse>? rows;

  ListConditionResponse(this.rc, this.rd, this.total, this.rows);

  factory ListConditionResponse.fromJson(Map<String, dynamic> json) =>
      _$ListConditionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListConditionResponseToJson(this);

  List<ConditionModel>? toDomain() => rows?.map((e) => e.toModel()).toList();

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ConditionResponse extends Equatable {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;

  ConditionResponse(this.id, this.name);

  factory ConditionResponse.fromJson(Map<String, dynamic> json) =>
      _$ConditionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ConditionResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  ConditionModel toModel() => ConditionModel(id: id, name: name);
}
