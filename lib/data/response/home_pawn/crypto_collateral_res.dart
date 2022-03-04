import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crypto_collateral_res.g.dart';

@JsonSerializable()
class CryptoCollateralResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  CryptoCollateralResponse(this.code, this.data);

  factory CryptoCollateralResponse.fromJson(Map<String, dynamic> json) =>
      _$CryptoCollateralResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCollateralResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContentResponse extends Equatable {
  @JsonKey(name: 'content')
  List<DataResponse>? data;

  ContentResponse(this.data);

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  List<CryptoCollateralModel>? toDomain() =>
      data?.map((e) => e.toDomain()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'description')
  String? name;
  @JsonKey(name: 'collateralSymbol')
  String? collateralSymbol;
  @JsonKey(name: 'collateralAmount')
  double? collateralAmount;
  @JsonKey(name: 'loanSymbol')
  String? loanTokenSymbol;
  @JsonKey(name: 'durationQty')
  num? duration;
  @JsonKey(name: 'durationType')
  int? durationType;

  DataResponse(this.name, this.collateralSymbol, this.collateralAmount,
      this.loanTokenSymbol, this.duration, this.durationType);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  CryptoCollateralModel toDomain() => CryptoCollateralModel(
        name: name,
        collateralAmount: collateralAmount,
        collateralSymbol: collateralSymbol,
        loanTokenSymbol: loanTokenSymbol,
        duration: duration,
        durationType: durationType,
      );
}
