import 'package:Dfy/data/response/create_hard_nft/list_evaluators_city_response.dart';

class EvaluatorsCityModel {
  String? id;
  String? name;
  String? avatarCid;
  int? starCount;
  int? reviewsCount;
  int? evaluatedCount;
  List<AcceptedAssetTypeResponse>? listAcceptedAssetType;
  String? description;

  EvaluatorsCityModel({
    this.id,
    this.name,
    this.avatarCid,
    this.starCount,
    this.reviewsCount,
    this.evaluatedCount,
    this.listAcceptedAssetType,
    this.description,
  });
}

class AcceptedAssetType {
  int? id;
  String? name;

  AcceptedAssetType({
    this.id,
    this.name,
  });
}
