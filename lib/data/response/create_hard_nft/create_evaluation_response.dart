import 'package:Dfy/domain/model/market_place/create_evaluation_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_evaluation_response.g.dart';

@JsonSerializable()
class CreateEvaluationResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'item')
  CreateItemResponse? item;

  CreateEvaluationResponse(
    this.rd,
    this.rc,
    this.traceId,
    this.item,
  );

  factory CreateEvaluationResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateEvaluationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreateEvaluationResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class CreateItemResponse extends Equatable {
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'asset')
  AssetResponse? asset;
  @JsonKey(name: 'evaluator_id')
  String? evaluatorId;
  @JsonKey(name: 'appointment_time')
  int? appointmentTime;
  @JsonKey(name: 'accepted_time')
  int? acceptedTime;
  @JsonKey(name: 'collection_type')
  int? collectionType;
  @JsonKey(name: 'customer_id')
  String? customerId;
  @JsonKey(name: 'bc_txn_hash')
  String? bcTxnHash;
  @JsonKey(name: 'bc_appointment_id')
  int? bcAppointmentId;
  @JsonKey(name: 'owner_address')
  String? ownerAddress;
  @JsonKey(name: 'evaluator_address')
  String? evaluatorAddress;
  @JsonKey(name: 'evaluation_fee')
  double? evaluationFee;
  @JsonKey(name: 'evaluation_fee_symbol')
  String? evaluationFeeSymbol;
  @JsonKey(name: 'created_at')
  int? createdAt;
  @JsonKey(name: 'updated_at')
  int? updatedAt;
  @JsonKey(name: 'request_id')
  int? requestId;

  CreateItemResponse(
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
  );

  factory CreateItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateItemResponseFromJson(json);

  CreateEvaluationModel toDomain() => CreateEvaluationModel(
        id: id,
        status: status,
        evaluatorId: evaluatorId,
        evaluationFee: evaluationFee,
        acceptedTime: acceptedTime,
        appointmentTime: appointmentTime,
        asset: asset,
        bcAppointmentId: bcAppointmentId,
        bcTxnHash: bcTxnHash,
        collectionType: collectionType,
        createdAt: createdAt,
        customerId: customerId,
        evaluationFeeSymbol: evaluationFeeSymbol,
        evaluatorAddress: evaluatorAddress,
        ownerAddress: ownerAddress,
        requestId: requestId,
        updatedAt: updatedAt,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class AssetResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'asset_type')
  AssetTypeRespone? assetType;
  @JsonKey(name: 'contact_name')
  String? contactName;

  AssetResponse(
    this.id,
    this.status,
    this.assetType,
    this.contactName,
  );

  factory AssetResponse.fromJson(Map<String, dynamic> json) =>
      _$AssetResponseFromJson(json);

  AssetCreateModel toDomain() => AssetCreateModel(
        id: id,
        assetType: assetType,
        contactName: contactName,
        status: status,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class AssetTypeRespone extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  AssetTypeRespone(
    this.id,
    this.name,
  );

  factory AssetTypeRespone.fromJson(Map<String, dynamic> json) =>
      _$AssetTypeResponeFromJson(json);

  AssetTypeCreateModel toDomain() => AssetTypeCreateModel(
        id: id,
        name: name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
