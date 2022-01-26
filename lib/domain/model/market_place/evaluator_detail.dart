import 'package:Dfy/data/response/create_hard_nft/evaluators_response.dart';

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
  List<AcceptedAssetTypeDetail>? acceptedAssetTypeList;
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
