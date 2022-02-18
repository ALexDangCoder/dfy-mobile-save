

class CreateEvaluationModel {
  int? status;
  String? id;
  AssetCreateModel? asset;
  String? evaluatorId;
  int? appointmentTime;
  int? acceptedTime;
  int? collectionType;
  String? customerId;
  String? bcTxnHash;
  int? bcAppointmentId;
  String? ownerAddress;
  String? evaluatorAddress;
  double? evaluationFee;
  String? evaluationFeeSymbol;
  int? createdAt;
  int? updatedAt;
  int? requestId;

  CreateEvaluationModel({
    this.status,
    this.id,
    this.asset,
    this.evaluatorId,
    this.appointmentTime,
    this.acceptedTime,
    this.collectionType,
    this.customerId,
    this.bcTxnHash,
    this.bcAppointmentId,
    this.ownerAddress,
    this.evaluatorAddress,
    this.evaluationFee,
    this.evaluationFeeSymbol,
    this.createdAt,
    this.updatedAt,
    this.requestId,
  });
}

class AssetCreateModel {
  String? id;
  int? status;
  AssetTypeCreateModel? assetType;
  String? contactName;

  AssetCreateModel({
    this.id,
    this.status,
    this.assetType,
    this.contactName,
  });
}

class AssetTypeCreateModel {
  int? id;
  String? name;

  AssetTypeCreateModel({
    this.id,
    this.name,
  });
}
