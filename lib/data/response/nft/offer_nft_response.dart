import 'package:Dfy/domain/model/offer_nft.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_nft_response.g.dart';

@JsonSerializable()
class OfferResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  DataResponse? item;

  OfferResponse(this.code, this.message, this.item);

  factory OfferResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse {
  @JsonKey(name: 'content')
  List<OfferDetailResponse>? content;

  DataResponse(this.content);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  List<OfferDetail>? toDomain() => content?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class OfferDetailResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'lender')
  String? addressLender;
  @JsonKey(name: 'reputation')
  num? reputation;
  @JsonKey(name: 'supplyCurrency')
  CurrencyResponse? currencyResponse;
  @JsonKey(name: 'duration')
  int? duration;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'interestPerYear')
  num? interestPerYear;
  @JsonKey(name: 'riskDefault')
  num? riskDefault;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'collateralId')
  int? collateralId;
  @JsonKey(name: 'bcOfferId')
  num? bcOfferId;
  @JsonKey(name: 'bcCollateralId')
  num? bcCollateralId;
  @JsonKey(name: 'liquidationThreshold')
  num? liquidationThreshold;
  @JsonKey(name: 'createAt')
  int? createAt;
  @JsonKey(name: 'name')
  String? name;

  OfferDetailResponse(
    this.id,
    this.createAt,
    this.addressLender,
    this.reputation,
    this.currencyResponse,
    this.duration,
    this.durationType,
    this.interestPerYear,
    this.riskDefault,
    this.status,
    this.collateralId,
    this.bcOfferId,
    this.bcCollateralId,
    this.liquidationThreshold,
    this.name,
  );

  factory OfferDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferDetailResponseToJson(this);

  OfferDetail toDomain() => OfferDetail(
        id: id,
        addressLender: addressLender,
        reputation: reputation,
        supplyCurrency: currencyResponse!.toDomain(),
        duration: duration,
        durationType: durationType,
        interestPerYear: interestPerYear,
        riskDefault: riskDefault,
        status: status,
        collateralId: collateralId,
        bcCollateralId: bcCollateralId,
        bcOfferId: bcOfferId,
        liquidationThreshold: liquidationThreshold,
        createAt: createAt,
        name: name,
      );
}

@JsonSerializable()
class CurrencyResponse {
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'tokenAddress')
  String? tokenAddress;

  CurrencyResponse(this.symbol, this.amount, this.tokenAddress);

  factory CurrencyResponse.fromJson(Map<String, dynamic> json) =>
      _$CurrencyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyResponseToJson(this);

  SupplyCurrency toDomain() => SupplyCurrency(
        symbol: symbol,
        amount: amount,
        tokenAddress: tokenAddress,
      );
}
