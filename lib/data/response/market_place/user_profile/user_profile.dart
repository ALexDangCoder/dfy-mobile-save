import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class UserProfileResponse extends Equatable {
  @JsonKey(name: 'activatedAt')
  int? activatedAt;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'birthday')
  String? birthday;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'isActive')
  bool? isActive;
  @JsonKey(name: 'kyc')
  dynamic kyc;
  @JsonKey(name: 'links')
  List<dynamic>? links;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'pawnShop')
  dynamic pawnShop;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'referredId')
  String? referredId;
  @JsonKey(name: 'role_type')
  int? roleType;
  UserProfileResponse();

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);

  UserProfileModel toDomain() => UserProfileModel(
    activatedAt: activatedAt,
    address: address,
    birthday : birthday,
    id: id,
    isActive: isActive,
    kyc: kyc,
    links: links,
    name: name,
    pawnShop: pawnShop,
    phoneNumber: phoneNumber,
    referredId: referredId,
    roleType: roleType,
  );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
