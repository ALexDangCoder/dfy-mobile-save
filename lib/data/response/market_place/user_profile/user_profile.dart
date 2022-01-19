import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile.g.dart';

@JsonSerializable()
class ProfileResponse extends Equatable {
  @JsonKey(name: 'data')
  Map<String,dynamic>? data;

  ProfileResponse();

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);

  ProfileModel toDomain() => ProfileModel(data: data);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

// class UserProfileResponse extends Equatable {

//   @JsonKey(name: 'email')
//   String? email;
//   @JsonKey(name: 'birthday')
//   dynamic birthday;
//   @JsonKey(name: 'phoneNumber')
//   String? phoneNumber;
//   @JsonKey(name: 'address')
//   dynamic address;
//   @JsonKey(name: 'isActive')
//   bool? isActive;
//   @JsonKey(name: 'createdAt')
//   int? createdAt;
//   @JsonKey(name: 'activatedAt')
//   int? activatedAt;
//   @JsonKey(name: 'links')
//   dynamic links;
//   @JsonKey(name: 'pawnShop')
//   dynamic pawnShop;
//   @JsonKey(name: 'kyc')
//   dynamic kyc;
//   @JsonKey(name: 'id')
//   int? id;
//   @JsonKey(name: 'name')
//   String? name;
//   @JsonKey(name: 'role_type')
//   int? roleType;
//   @JsonKey(name: 'referredId')
//   String? referredId;
//
//   UserProfileResponse();
//
//   factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
//       _$UserProfileResponseFromJson(json);
//
//   Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);
//
//   UserProfileModel toDomain() => UserProfileModel(
//     activatedAt: activatedAt,
//     address: address,
//     birthday: birthday,
//     id: id,
//     isActive: isActive,
//     kyc: kyc,
//     links: links,
//     name: name,
//     pawnShop: pawnShop,
//     phoneNumber: phoneNumber,
//     referredId: referredId,
//     roleType: roleType,
//     createdAt: createdAt,
//     email: email,
//   );
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => throw UnimplementedError();
// }
