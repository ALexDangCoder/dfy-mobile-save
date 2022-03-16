

import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_pawnshop_response.g.dart';

@JsonSerializable()
class DetailPawnShopResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  DataResponse? data;

  DetailPawnShopResponse(this.code, this.data);

  factory DetailPawnShopResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailPawnShopResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailPawnShopResponseToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
@JsonSerializable()
class DataResponse extends Equatable {
  @JsonKey(name: 'collateralTokens')
  List<AcceptableAssetsAsCollateralResponse>? acceptableAssetsAsCollateral;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'interest')
  num? interest;
  @JsonKey(name: 'interestMax')
  num? interestMax;
  @JsonKey(name: 'interestMin')
  num? interestMin;
  @JsonKey(name: 'isFavourite')
  bool? isFavourite;
  @JsonKey(name: 'loanToValue')
  num? loanToValue;
  @JsonKey(name: 'durationQtyType')
  int? durationQtyType;
  @JsonKey(name: 'pawnShop')
  PawnshopResponse? pawnshop;
  @JsonKey(name: 'durationQtyMin')
  int? durationQtyTypeMin;
  @JsonKey(name: 'durationQtyMax')
  int? durationQtyTypeMax;
  @JsonKey(name: 'signedContracts')
  int? signContracts;
  @JsonKey(name: 'repaymentTokens')
  List<RepaymentTokensResponse>? repaymentToken;
  @JsonKey(name: 'loanTokens')
  List<LoanTokensResponse>? loanToken;
  @JsonKey(name: 'associatedWalletAddress')
  String? associatedWalletAddress;
  @JsonKey(name: 'bcPackageId')
  int? bcPackageId;
  @JsonKey(name: 'allowedLoanMax')
  num? allowedLoanMax;
  @JsonKey(name: 'allowedLoanMin')
  num? allowedLoanMin;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'liquidationThreshold')
  num? liquidationThreshold;
  @JsonKey(name: 'recurringInterest')
  int? recurringInterest;


  DataResponse(
      this.acceptableAssetsAsCollateral,
      this.id,
      this.type,
      this.interest,
      this.interestMax,
      this.interestMin,
      this.isFavourite,
      this.loanToValue,
      this.durationQtyType,
      this.pawnshop,
      this.durationQtyTypeMin,
      this.durationQtyTypeMax,
      this.signContracts,
      this.repaymentToken,
      this.loanToken,
      this.associatedWalletAddress,
      this.bcPackageId,
      this.allowedLoanMax,
      this.allowedLoanMin,
      this.name,
      this.liquidationThreshold,
      this.recurringInterest);

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
    type: type,
    interestMax: interestMax,
    interestMin: interestMin,
    pawnshop: pawnshop?.toDomain(),
    durationQtyTypeMax: durationQtyTypeMax,
    durationQtyTypeMin: durationQtyTypeMin,
    signContracts: signContracts,
    repaymentToken: repaymentToken?.map((e) => e.toDomain()).toList(),
    loanToken: loanToken?.map((e) => e.toDomain()).toList(),
    associatedWalletAddress: associatedWalletAddress,
    bcPackageId: bcPackageId,
    allowedLoanMax: allowedLoanMax,
    allowedLoanMin: allowedLoanMin,
    name: name,
    liquidationThreshold: liquidationThreshold,
    recurringInterest: recurringInterest,
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

@JsonSerializable()
class RepaymentTokensResponse extends Equatable {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'symbol')
  String? symbol;

  RepaymentTokensResponse(this.address, this.symbol);

  factory RepaymentTokensResponse.fromJson(
      Map<String, dynamic> json) =>
      _$RepaymentTokensResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$RepaymentTokensResponseToJson(this);

  RepaymentToken toDomain() => RepaymentToken(
    address: address,
    symbol: symbol,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@JsonSerializable()
class LoanTokensResponse extends Equatable {
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'symbol')
  String? symbol;

  LoanTokensResponse(this.address, this.symbol);

  factory LoanTokensResponse.fromJson(
      Map<String, dynamic> json) =>
      _$LoanTokensResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LoanTokensResponseToJson(this);

  LoanToken toDomain() => LoanToken(
    address: address,
    symbol: symbol,
  );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
