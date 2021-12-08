import 'package:Dfy/data/response/token/token_response.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_token_response.g.dart';

@JsonSerializable()
class ListTokenResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  List<TokenResponse>? data;
  @JsonKey(name: 'trace_id')
  String? traceId;

  ListTokenResponse(
    this.error,
    this.code,
    this.traceId,
    this.data,
  );

  factory ListTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListTokenResponseToJson(this);

  @override
  List<Object?> get props => [];

  List<TokenInf>? toDomain() => data?.map((e) => e.toDomain()).toList();
}
