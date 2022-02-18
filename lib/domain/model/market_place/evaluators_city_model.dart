class EvaluatorsCityModel {
  String? id;
  String? name;
  String? avatarCid;
  int? starCount;
  int? reviewsCount;
  int? evaluatedCount;
  List<AcceptedAssetType>? listAcceptedAssetType;
  String? description;
  double? locationLat;
  double? locationLong;

  EvaluatorsCityModel({
    this.id,
    this.name,
    this.avatarCid,
    this.starCount,
    this.reviewsCount,
    this.evaluatedCount,
    this.listAcceptedAssetType,
    this.description,
    this.locationLat,
    this.locationLong,
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
