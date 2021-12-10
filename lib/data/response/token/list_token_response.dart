import 'package:Dfy/data/response/token/token_response.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_token_response.g.dart';

@JsonSerializable()
class ListTokenResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'rows')
  List<TokenResponse>? rows;


  ListTokenResponse(this.rc, this.total, this.rows);

  factory ListTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$ListTokenResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListTokenResponseToJson(this);

  @override
  List<Object?> get props => [];

  List<TokenInf>? toDomain() => rows?.map((e) => e.toDomain()).toList();
}
