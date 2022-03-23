import 'package:Dfy/domain/model/hard_nft_my_account/step1/city_model.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/step1/country_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';

class UserProfile {
  String? email;
  int? birthday;
  String? phoneNumber;
  String? address;
  String? referredId;
  bool? isActive;
  int? createAtl;
  int? activatedAt;
  List<String>? links;
  Pawnshop? pawnshop;
  int? id;
  String? name;
  int? roleType;
  KYC? kyc;

  UserProfile({
    this.email,
    this.birthday,
    this.phoneNumber,
    this.address,
    this.referredId,
    this.isActive,
    this.createAtl,
    this.activatedAt,
    this.links,
    this.pawnshop,
    this.id,
    this.name,
    this.roleType,
    this.kyc,
  });
}

class KYC {
  int? id;
  String? firstName;
  String? name;
  String? lastName;
  String? middleName;
  int? typePhoto;
  String? frontPhoto;
  String? backPhoto;
  String? selfiePhoto;
  int? kycNumber;
  String? address;
  int? status;
  int? dateOfBirth;
  CountryModel? country;
  CityModel? city;
  bool? isActive;
  String? walletAddress;
  String? email;
  int? createAt;
  int? verifyAt;
  String? emailAdminVerify;

  KYC({
    this.id,
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
    this.emailAdminVerify,
  });
}
