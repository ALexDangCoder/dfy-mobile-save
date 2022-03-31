import 'dart:convert';

import 'package:Dfy/domain/model/pawn/user_profile.dart';
import 'package:Dfy/utils/extensions/map_extension.dart';

UserProfileModel userProfileFromJson(String str) {
  return UserProfileModel.fromJson(json.decode(str));
}

String userProfileToJson(UserProfileModel data) => json.encode(data.toJson());

class ProfileModel{
  Map<String, dynamic>? data;

  ProfileModel({this.data});
}

class UserProfileModel {
  int? activatedAt;
  String? address;
  String? birthday;
  int? createdAt;
  String? email;
  int? id;
  bool? isActive;
  KYC? kyc;
  List<dynamic>? links;
  String? name;
  dynamic pawnShop;
  String? phoneNumber;
  String? referredId;
  int? roleType;

  UserProfileModel({
    this.activatedAt,
    this.address,
    this.birthday,
    this.id,
    this.isActive,
    this.email,
    this.createdAt,
    this.kyc,
    this.links,
    this.name,
    this.pawnShop,
    this.phoneNumber,
    this.referredId,
    this.roleType,
  });

  Map<String, dynamic> toJson() => <String, dynamic>{
        'activatedAt': activatedAt,
        'address': address,
        'birthday': birthday,
        'createdAt': createdAt,
        'email': email,
        'id': id,
        'isActive': isActive,
        'kyc': kyc,
        'links': links,
        'name': name,
        'pawnShop': pawnShop,
        'phoneNumber': phoneNumber,
        'referredId': referredId,
        'roleType': roleType,
      };

  UserProfileModel.fromJson(Map<String,dynamic> json)
      : activatedAt = json.intValue('activatedAt'),
        address = json.stringValueOrEmpty('address'),
        birthday = json.stringValueOrEmpty('birthday'),
        createdAt = json.intValue('createdAt'),
        email = json.stringValueOrEmpty('email'),
        id = json.intValue('id'),
        isActive = json.boolValue('isActive'),
        kyc = json['kyc'],
        links = json.arrayValueOrEmpty('links'),
        name = json.stringValueOrEmpty('name'),
        pawnShop = json['pawnShop'],
        phoneNumber = json.stringValueOrEmpty('phoneNumber'),
        referredId = json.stringValueOrEmpty('referredId'),
        roleType = json.intValue('roleType');
}
