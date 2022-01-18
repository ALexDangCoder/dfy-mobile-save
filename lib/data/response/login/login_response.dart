import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends Equatable {
  @JsonKey(name: 'access_token')
  String? accessToken;
  @JsonKey(name: 'expires_in')
  int? expiresIn;
  @JsonKey(name: 'refresh_token')
  dynamic refreshToken;
  @JsonKey(name: 'scope')
  String? scope;
  @JsonKey(name: 'token_type')
  String? tokenType;

  LoginResponse();

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  LoginModel toDomain() => LoginModel(
      accessToken: accessToken,
      expiresIn: expiresIn,
      refreshToken: refreshToken,
      scope: scope,
      tokenType: tokenType);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
