import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_profile_response.g.dart';

@JsonSerializable()
class UserProfileResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  UserProfileResponse(this.data);

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'birthday')
  int? birthday;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'referredId')
  String? referredId;
  @JsonKey(name: 'isActive')
  bool? isActive;
  @JsonKey(name: 'createAt')
  int? createAt;
  @JsonKey(name: 'activatedAt')
  int? activatedAt;
  @JsonKey(name: 'links')
  List<String>? links;
  @JsonKey(name: 'pawnShop')
  PawnshopResponse? pawnshop;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'roleType')
  int? roleType;
  @JsonKey(name: 'kyc')
  KycResponse? kyc;


  DataResponse(
      this.email,
      this.birthday,
      this.phoneNumber,
      this.address,
      this.referredId,
      this.isActive,
      this.createAt,
      this.activatedAt,
      this.links,
      this.pawnshop,
      this.id,
      this.name,
      this.roleType,
      this.kyc);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  UserProfile toDomain() => UserProfile(
    email: email,
    birthday: birthday,
    phoneNumber: phoneNumber,
    address: address,
    referredId: referredId,
    isActive: isActive,
    createAtl: createAt,
    activatedAt: activatedAt,
    links: links,
    pawnshop: pawnshop?.toDomain(),
    id: id,
    name: name,
    roleType: roleType,
    kyc: kyc?.toDomain(),
  );
}

@JsonSerializable()
class PawnshopResponse extends Equatable {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'coverImage')
  String? cover;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'createdAt')
  int? createAt;
  @JsonKey(name: 'updatedAt')
  int? updateAt;


  PawnshopResponse(this.address,
      this.avatar,
      this.cover,
      this.name,
      this.id,
      this.type,
      this.userId,
      this.email,
      this.description,
      this.phoneNumber,
      this.createAt,
      this.updateAt);

  factory PawnshopResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnshopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PawnshopResponseToJson(this);

  Pawnshop toDomain() =>
      Pawnshop(
        address: address,
        avatar: avatar,
        cover: cover,
        name: name,
        id: id,
        type: type,
        userId: userId,
        email: email,
        description: description,
        phoneNumber: phoneNumber,
        createAt: createAt,
        updateAt: updateAt,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class KycResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'firstName')
  String? firstName;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'lastName')
  String? lastName;
  @JsonKey(name: 'middleName')
  String? middleName;
  @JsonKey(name: 'typePhoto')
  int? typePhoto;
  @JsonKey(name: 'frontPhoto')
  String? frontPhoto;
  @JsonKey(name: 'backPhoto')
  String? backPhoto;
  @JsonKey(name: 'selfiePhoto')
  String? selfiePhoto;
  @JsonKey(name: 'kycNumber')
  int? kycNumber;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'dateOfBirth')
  int? dateOfBirth;
  @JsonKey(name: 'country')
  CountryResponse? country;
  @JsonKey(name: 'city')
  CityResponse? city;
  @JsonKey(name: 'isActive')
  bool? isActive;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'createAt')
  int? createAt;
  @JsonKey(name: 'verifyAt')
  int? verifyAt;
  @JsonKey(name: 'emailAdminVerify')
  String? emailAdminVerify;


  KycResponse(this.id,
      this.firstName,
      this.name,
      this.lastName,
      this.middleName,
      this.typePhoto,
      this.frontPhoto,
      this.backPhoto,
      this.selfiePhoto,
      this.kycNumber,
      this.address,
      this.status,
      this.dateOfBirth,
      this.country,
      this.city,
      this.isActive,
      this.walletAddress,
      this.email,
      this.createAt,
      this.verifyAt,
      this.emailAdminVerify);

  factory KycResponse.fromJson(Map<String, dynamic> json) =>
      _$KycResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KycResponseToJson(this);

  KYC toDomain() => KYC(
    id: id,
    name: name,
    firstName: firstName,
    lastName: lastName,
    middleName: middleName,
    typePhoto: typePhoto,
    frontPhoto: frontPhoto,
    backPhoto: backPhoto,
    selfiePhoto: selfiePhoto,
    kycNumber: kycNumber,
    address: address,
    status: status,
    dateOfBirth: dateOfBirth,
    country: country?.toDomain(),
    city: city?.toDomain(),
    isActive: isActive,
    walletAddress: walletAddress,
    email: email,
    createAt: createAt,
    verifyAt: verifyAt,
    emailAdminVerify: emailAdminVerify,
  );
}

@JsonSerializable()
class CityResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'countryId')
  int? countryId;

  CityResponse(this.id, this.name, this.countryId);

  factory CityResponse.fromJson(Map<String, dynamic> json) =>
      _$CityResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CityResponseToJson(this);

  CityModel toDomain() =>
      CityModel(
        id: id,
        name: name,
        countryID: countryId,
      );
}

@JsonSerializable()
class CountryResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  CountryResponse(this.id, this.name);

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      _$CountryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CountryResponseToJson(this);

  CountryModel toDomain() =>
      CountryModel(
        id: id.toString(),
        name: name,
      );
}
