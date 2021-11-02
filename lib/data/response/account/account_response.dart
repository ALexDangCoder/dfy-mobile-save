import 'package:Dfy/domain/model/user.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account_response.g.dart';

@JsonSerializable()
class AccountResponse extends Equatable {
  @JsonKey(name: 'token')
  String token;

  AccountResponse(
    this.token,
  );

  factory AccountResponse.fromJson(Map<String, dynamic> json) =>
      _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);

  @override
  List<Object?> get props => [token];

  UserModel toDomain() => UserModel(token: token);
}
