

class EvaluatorsDetailModel {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? website;
  String? description;
  double? locationLat;
  double? locationLong;
  List<AcceptedAssetTypeDetailModel>? acceptedAssetTypeList;
  int? workingTimeFrom;
  int? workingTimeTo;
  List<int>? workingDays;
  String? coverCid;
  String? avatarCid;
  String? walletAddress;
  int? starCount;
  int? reviewsCount;
  int? evaluatedCount;
  int? createdAt;
  PhoneCode? phoneCode;

  EvaluatorsDetailModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.website,
    this.description,
    this.locationLat,
    this.locationLong,
    this.acceptedAssetTypeList,
    this.workingTimeFrom,
    this.workingTimeTo,
    this.workingDays,
    this.coverCid,
    this.avatarCid,
    this.walletAddress,
    this.starCount,
    this.reviewsCount,
    this.evaluatedCount,
    this.createdAt,
    this.phoneCode,
  });
}

class AcceptedAssetTypeDetailModel {
  String? name;
  int? id;

  AcceptedAssetTypeDetailModel(
    this.name,
    this.id,
  );
}

class PhoneCode {
  int? id;
  String? name;
  String? code;

  PhoneCode({
    this.id,
    this.name,
    this.code,
  });
}
