import 'package:Dfy/domain/model/home_pawn/offers_received_model.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_received_response.g.dart';

@JsonSerializable()
class OfferReceivedResponse extends Equatable {
  @JsonKey(name: 'data')
  DataResponse? data;

  OfferReceivedResponse(this.data);

  factory OfferReceivedResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferReceivedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferReceivedResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'content')
  List<ContentResponse>? content;

  DataResponse(
    this.content,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

@JsonSerializable()
class ContentResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'lender')
  String? lender;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'supplyCurrency')
  TokenRespone? supplyCurrency;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'interestPerYear')
  int? interestPerYear;
  @JsonKey(name: 'riskDefault')
  int? riskDefault;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'collateralId')
  int? collateralId;
  @JsonKey(name: 'bcOfferId')
  int? bcOfferId;
  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;
  @JsonKey(name: 'liquidationThreshold')
  int? liquidationThreshold;
  @JsonKey(name: 'createdAt')
  int? createdAt;
  @JsonKey(name: 'name')
  String? name;

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  ContentResponse(
    this.id,
    this.lender,
    this.reputation,
    this.supplyCurrency,
    this.duration,
    this.durationType,
    this.interestPerYear,
    this.riskDefault,
    this.status,
    this.collateralId,
    this.bcOfferId,
    this.bcCollateralId,
    this.liquidationThreshold,
    this.createdAt,
    this.name,
  );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  OffersReceivedModel toDomain() => OffersReceivedModel(
        createdAt: createdAt,
        status: status,
        supplyCurrency: supplyCurrency?.toDomain(),
        id: id,
        collateralId: collateralId,
        duration: duration,
        liquidationThreshold: liquidationThreshold,
        durationType: durationType,
        bcOfferId: bcOfferId,
        bcCollateralId: bcCollateralId,
        reputation: reputation,
        name: name,
        interestPerYear: interestPerYear,
        lender: lender,
        riskDefault: riskDefault,
      );
}

@JsonSerializable()
class TokenRespone extends Equatable {
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'address')
  String? address;

  factory TokenRespone.fromJson(Map<String, dynamic> json) =>
      _$TokenResponeFromJson(json);

  Map<String, dynamic> toJson() => _$TokenResponeToJson(this);

  TokenRespone(
    this.symbol,
    this.amount,
    this.address,
  );

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  TokenModelPawn toDomain() => TokenModelPawn(
        symbol: symbol,
        address: address,
        amount: amount,
      );
}
