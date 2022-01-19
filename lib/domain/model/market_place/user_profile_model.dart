class UserProfileModel {
  int? activatedAt;
  String? address;
  String? birthday;
  int? id;
  bool? isActive;
  dynamic kyc;
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
    this.kyc,
    this.links,
    this.name,
    this.pawnShop,
    this.phoneNumber,
    this.referredId,
    this.roleType,
  });

// Map<String, dynamic> toJson() =>
//     <String, dynamic>{
//       'activatedAt': activatedAt,
//       'address': address,
//       'birthday': birthday,
//       'id': id,
//       'isActive': isActive,
//       'kyc': kyc,
//       'links': links,
//       'name': name,
//       'pawnShop': pawnShop,
//       'phoneNumber': phoneNumber,
//       'referredId': referredId,
//       'pawnShop': pawnShop,
//       'roleType': roleType,
//     };
//
// UserProfileModel.fromLogin(dynamic json)
//     : accessToken = json['accessToken'].toString(),
//       expiresIn = json['expiresIn'],
//       refreshToken = json['refreshToken'].toString(),
//       scope = json['scope'].toString(),
//       tokenType = json['tokenType'].toString();
}
