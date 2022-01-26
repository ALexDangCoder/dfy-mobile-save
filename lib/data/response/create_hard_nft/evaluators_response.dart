import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'evaluators_response.g.dart';

@JsonSerializable()
class EvaluatorsDetailResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'item')
  EvaluatorResponse? item;

  EvaluatorsDetailResponse(
    this.rd,
    this.rc,
    this.item,
    this.traceId,
  );

  factory EvaluatorsDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluatorsDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EvaluatorsDetailResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class EvaluatorResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'website')
  String? website;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'location_lat')
  double? locationLat;
  @JsonKey(name: 'locationLong')
  double? locationLong;
  @JsonKey(name: 'accepted_asset_type_list')
  List<AcceptedAssetTypeDetail>? acceptedAssetTypeList;
  @JsonKey(name: 'working_time_from')
  int? workingTimeFrom;
  @JsonKey(name: 'working_time_to')
  int? workingTimeTo;
  @JsonKey(name: 'working_days')
  List<int>? workingDays;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'star_count')
  int? starCount;
  @JsonKey(name: 'reviews_count')
  int? reviewsCount;
  @JsonKey(name: 'evaluated_count')
  int? evaluatedCount;
  @JsonKey(name: 'created_at')
  int? createdAt;

  EvaluatorResponse(
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
  );

  factory EvaluatorResponse.fromJson(Map<String, dynamic> json) =>
      _$EvaluatorResponseFromJson(json);

  EvaluatorsDetailModel toDomain() => EvaluatorsDetailModel(
        id: id,
        name: name,
        email: email,
        phone: phone,
        address: address,
        website: website,
        description: description,
        locationLat: locationLat,
        locationLong: locationLong,
        acceptedAssetTypeList: acceptedAssetTypeList,
        workingTimeFrom: workingTimeFrom,
        workingTimeTo: workingTimeTo,
        workingDays: workingDays,
        coverCid: coverCid,
        avatarCid: avatarCid,
        walletAddress: walletAddress,
        starCount: starCount,
        reviewsCount: reviewsCount,
        evaluatedCount: evaluatedCount,
        createdAt: createdAt,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class AcceptedAssetTypeDetail extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;

  AcceptedAssetTypeDetail(
    this.id,
    this.name,
  );

  factory AcceptedAssetTypeDetail.fromJson(Map<String, dynamic> json) =>
      _$AcceptedAssetTypeDetailFromJson(json);

  AcceptedAssetTypeDetailModel toDomain() => AcceptedAssetTypeDetailModel(
        name,
        id,
      );

  @override
  List<Object?> get props => [];
}
