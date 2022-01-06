import 'package:Dfy/domain/model/market_place/nonce_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nonce_response.g.dart';

@JsonSerializable()
class NonceResponse extends Equatable {
  @JsonKey(name: 'data')
  String? data;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'role')
  dynamic role;
  @JsonKey(name: 'traceId')
  String? traceId;

  NonceResponse();

  factory NonceResponse.fromJson(Map<String, dynamic> json) =>
      _$NonceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NonceResponseToJson(this);

  NonceModel toDomain() => NonceModel(code: code, data: data);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
