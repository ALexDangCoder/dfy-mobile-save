import 'package:Dfy/data/response/home_pawn/detail_pawnshop_response.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'detail_pawn_shop_package_response.g.dart';

@JsonSerializable()
class DetailPawnShopPackageResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'data')
  DataResponse? data;

  DetailPawnShopPackageResponse(this.code, this.data);

  factory DetailPawnShopPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailPawnShopPackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailPawnShopPackageResponseToJson(this);

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
  @JsonKey(name: 'totalSentOffer')
  int? totalSentOffer;
  @JsonKey(name: 'status')
  int? status;

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
      this.recurringInterest,
      this.totalSentOffer,
      this.status);

  factory DataResponse.fromJson(Map<String, dynamic> json) =>
      _$DataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseToJson(this);

  PawnshopPackage toDomain() => PawnshopPackage(
        acceptableAssetsAsCollateral:
            acceptableAssetsAsCollateral?.map((e) => e.toDomain()).toList(),
        id: id,
        status: status,
        totalSentOffer: totalSentOffer,
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
