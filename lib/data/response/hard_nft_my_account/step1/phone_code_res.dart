import 'package:Dfy/domain/model/hard_nft_my_account/step1/phone_code_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_code_res.g.dart';

@JsonSerializable()
class ListPhoneCodeResponse extends Equatable {
  @JsonKey(name: 'rc')
  int rc;
  @JsonKey(name: 'rd')
  String rd;
  @JsonKey(name: 'total')
  int total;
  @JsonKey(name: 'rows')
  List<PhoneCodeResponse>? rows;

  ListPhoneCodeResponse(this.rc, this.rd, this.total, this.rows);

  factory ListPhoneCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$ListPhoneCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListPhoneCodeResponseToJson(this);

  List<PhoneCodeModel>? toDomain() => rows?.map((e) => e.toModel()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class PhoneCodeResponse extends Equatable {
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'code')
  String code;

  PhoneCodeResponse(this.id, this.name, this.code);

  factory PhoneCodeResponse.fromJson(Map<String, dynamic> json) =>
      _$PhoneCodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneCodeResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];

  PhoneCodeModel toModel() => PhoneCodeModel(
        id,
        name,
        code,
      );
}
