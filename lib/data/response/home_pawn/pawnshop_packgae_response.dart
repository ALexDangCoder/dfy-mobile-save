import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pawnshop_packgae_response.g.dart';

@JsonSerializable()
class PawnshopPackageResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  ContentResponse? data;

  PawnshopPackageResponse(this.code, this.data);

  factory PawnshopPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnshopPackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PawnshopPackageResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class ContentResponse extends Equatable{
  @JsonKey(name: 'content')
  List<DataResponse>? data;

  ContentResponse(this.data);

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ContentResponseToJson(this);

  List<PawnshopPackage>? toDomain() => data?.map((e) => e.toDomain()).toList();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'acceptableAssetsAsCollateral')
  List<AcceptableAssetsAsCollateralResponse>? acceptableAssetsAsCollateral;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'interest')
  num? interest;
  @JsonKey(name: 'isFavourite')
  bool? isFavourite;
  @JsonKey(name: 'loanToValue')
  num? loanToValue;
  @JsonKey(name: 'durationQtyType')
  int? durationQtyType;
  @JsonKey(name: 'pawnShop')
  PawnshopResponse? pawnshop;

  DataResponse(
    this.acceptableAssetsAsCollateral,
    this.id,
    this.interest,
    this.isFavourite,
    this.loanToValue,
    this.durationQtyType,
    this.pawnshop,
  );

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  PawnshopPackage toDomain() => PawnshopPackage(
        acceptableAssetsAsCollateral:
            acceptableAssetsAsCollateral?.map((e) => e.toDomain()).toList(),
        id: id,
        interest: interest,
        isFavourite: isFavourite,
        loanToValue: loanToValue,
        durationQtyType: durationQtyType,
        pawnshop: pawnshop?.toDomain(),
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class AcceptableAssetsAsCollateralResponse extends Equatable {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'symbol')
  String? symbol;

  AcceptableAssetsAsCollateralResponse(this.address, this.symbol);

  factory AcceptableAssetsAsCollateralResponse.fromJson(
          Map<String, dynamic> json) =>
      _$AcceptableAssetsAsCollateralResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AcceptableAssetsAsCollateralResponseToJson(this);

  AcceptableAssetsAsCollateral toDomain() => AcceptableAssetsAsCollateral(
        address: address,
        symbol: symbol,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class PawnshopResponse extends Equatable {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'cover')
  String? cover;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'isKYC')
  bool? isKYC;
  @JsonKey(name: 'isTrustedLender')
  bool? isTrustedLender;
  @JsonKey(name: 'reputation')
  int? reputation;

  PawnshopResponse(
      this.address,
      this.avatar,
      this.cover,
      this.name,
      this.id,
      this.type,
      this.userId,
      this.isKYC,
      this.isTrustedLender,
      this.reputation);

  factory PawnshopResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnshopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PawnshopResponseToJson(this);

  Pawnshop toDomain() => Pawnshop(
        address: address,
        avatar: avatar,
        cover: cover,
        name: name,
        id: id,
        type: type,
        userId: userId,
        isKYC: isKYC,
        isTrustedLender: isTrustedLender,
        reputation: reputation,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
