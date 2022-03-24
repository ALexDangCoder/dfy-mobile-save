import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_crypto_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'offer_sent_crypto_response.g.dart';

@JsonSerializable()
class OfferSentCryptoTotalResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;

  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  dynamic message;

  @JsonKey(name: 'data')
  OfferSentCryptoListResponse data;

  @JsonKey(name: 'trace_id')
  String? traceId;

  OfferSentCryptoTotalResponse(
    this.error,
    this.code,
    this.message,
    this.data,
    this.traceId,
  );

  factory OfferSentCryptoTotalResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferSentCryptoTotalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferSentCryptoTotalResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class OfferSentCryptoListResponse extends Equatable {
  @JsonKey(name: 'content')
  List<OfferSentCryptoItemResponse>? content;

  OfferSentCryptoListResponse(this.content);

  factory OfferSentCryptoListResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferSentCryptoListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferSentCryptoListResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class OfferSentCryptoItemResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'durationQty')
  int? durationQty;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'interestRate')
  int? interestRate;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'riskDefault')
  int? riskDefault;
  @JsonKey(name: 'bcOfferId')
  int? bcOfferId;
  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;
  @JsonKey(name: 'liquidationThreshold')
  int? liquidationThreshold;
  @JsonKey(name: 'lenderWalletAddress')
  String? lenderWalletAddress;
  @JsonKey(name: 'supplyCurrency')
  SupplyCurrencyResponse? supplyCurrency;

  OfferSentCryptoItemResponse(
    this.id,
    this.durationQty,
    this.durationType,
    this.interestRate,
    this.status,
    this.description,
    this.riskDefault,
    this.bcOfferId,
    this.bcCollateralId,
    this.liquidationThreshold,
    this.lenderWalletAddress,
    this.supplyCurrency,
  );

  OfferSentCryptoModel toModel() => OfferSentCryptoModel(
        description: description,
        bcCollateralId: bcCollateralId,
        durationQty: durationQty,
        durationType: durationType,
        status: status,
        id: id,
        bcOfferId: bcOfferId,
        interestRate: interestRate,
        lenderWalletAddress: lenderWalletAddress,
        liquidationThreshold: liquidationThreshold,
        riskDefault: riskDefault,
        supplyCurrency: supplyCurrency?.toModel(),
      );

  factory OfferSentCryptoItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OfferSentCryptoItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfferSentCryptoItemResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class SupplyCurrencyResponse extends Equatable {
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'amount')
  double? amount;
  @JsonKey(name: 'address')
  String? address;

  SupplyCurrencyResponse(
    this.symbol,
    this.amount,
    this.address,
  );

  SupplyCurrencyModel toModel() => SupplyCurrencyModel(
        symbol: symbol,
        address: address,
        amount: amount,
      );

  factory SupplyCurrencyResponse.fromJson(Map<String, dynamic> json) =>
      _$SupplyCurrencyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SupplyCurrencyResponseToJson(this);

  @override
  List<Object?> get props => [];
}
