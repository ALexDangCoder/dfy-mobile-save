import 'package:Dfy/data/response/home_pawn/contract_detail_response.dart';
import 'package:Dfy/data/response/home_pawn/detail_pawnshop_response.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_pawn_shop_package_response.g.dart';

@JsonSerializable()
class PawnShopPackageTotalResponse extends Equatable {
  @JsonKey(name: 'data')
  ListPawnShopPackageTotalResponse? data;

  PawnShopPackageTotalResponse(this.data);

  factory PawnShopPackageTotalResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnShopPackageTotalResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PawnShopPackageTotalResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ListPawnShopPackageTotalResponse extends Equatable {
  @JsonKey(name: 'content')
  List<ItemPawnShopPackageResponse>? content;

  ListPawnShopPackageTotalResponse(this.content);

  factory ListPawnShopPackageTotalResponse.fromJson(
          Map<String, dynamic> json) =>
      _$ListPawnShopPackageTotalResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ListPawnShopPackageTotalResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ItemPawnShopPackageResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'pawnShopId')
  num? pawnShopId;
  @JsonKey(name: 'status')
  num? status;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'isDeleted')
  bool? isDeleted;
  @JsonKey(name: 'durationQtyType')
  int? durationQtyType;
  @JsonKey(name: 'durationQtyMin')
  int? durationQtyMin;
  @JsonKey(name: 'durationQtyMax')
  int? durationQtyMax;
  @JsonKey(name: 'associatedWalletAddress')
  String? associatedWalletAddress;
  @JsonKey(name: 'bcPackageId')
  int? bcPackageId;
  @JsonKey(name: 'loanToValue')
  num? loanToValue;
  @JsonKey(name: 'interest')
  num? interest;
  @JsonKey(name: 'liquidationThreshold')
  num? liquidationThreshold;
  @JsonKey(name: 'recurringInterest')
  int? recurringInterest;
  @JsonKey(name: 'allowedLoanMax')
  num? allowedLoanMax;
  @JsonKey(name: 'allowedLoanMin')
  num? allowedLoanMin;
  @JsonKey(name: 'collateralReceived')
  num? collateralReceived;
  @JsonKey(name: 'loanTokens')
  List<LoanTokensResponse>? loanTokens;
  @JsonKey(name: 'collateralTokens')
  List<AcceptableAssetsAsCollateralResponse>? collateralTokens;
  @JsonKey(name: 'repaymentTokens')
  List<RepaymentTokensResponse>? repaymentTokens;

  ItemPawnShopPackageResponse(
    this.id,
    this.pawnShopId,
    this.status,
    this.name,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.durationQtyType,
    this.durationQtyMin,
    this.durationQtyMax,
    this.associatedWalletAddress,
    this.bcPackageId,
    this.loanToValue,
    this.interest,
    this.liquidationThreshold,
    this.recurringInterest,
    this.allowedLoanMax,
    this.allowedLoanMin,
    this.collateralReceived,
    this.loanTokens,
    this.collateralTokens,
    this.repaymentTokens,
  );

  PawnshopPackage toPawnShop() => PawnshopPackage(
        recurringInterest: recurringInterest,
        interest: interest,
        durationQtyType: durationQtyType,
        bcPackageId: bcPackageId,
        associatedWalletAddress: associatedWalletAddress,
        allowedLoanMax: allowedLoanMax,
        allowedLoanMin: allowedLoanMin,
        name: name,
        loanToValue: loanToValue,
        liquidationThreshold: liquidationThreshold,
        type: type,
        id: id,
        durationQtyTypeMax: durationQtyMax,
        durationQtyTypeMin: durationQtyMin,
        acceptableAssetsAsCollateral:
            collateralTokens?.map((e) => e.toDomain()).toList(),
        pawnShopId: pawnShopId,
        repaymentToken: repaymentTokens?.map((e) => e.toDomain()).toList(),
        loanToken: loanTokens?.map((e) => e.toDomain()).toList(),
      );

  // PawnShopPackageModel toModel() => PawnShopPackageModel(
  //       name: name,
  //       status: status,
  //       id: id,
  //       type: type,
  //       loanToValue: loanToValue,
  //       createdAt: createdAt,
  //       liquidationThreshold: liquidationThreshold,
  //       updatedAt: updatedAt,
  //       allowedLoanMin: allowedLoanMin,
  //       allowedLoanMax: allowedLoanMax,
  //       isDeleted: isDeleted,
  //       associatedWalletAddress: associatedWalletAddress,
  //       bcPackageId: bcPackageId,
  //       collateralReceived: collateralReceived,
  //       collateralTokens: collateralTokens?.map((e) => e.toDomain()).toList(),
  //       durationQtyMax: durationQtyMax,
  //       durationQtyMin: durationQtyMin,
  //       durationQtyType: durationQtyType,
  //       interest: interest,
  //       loanTokens: loanTokens?.map((e) => e.toDomain()).toList(),
  //       pawnShopId: pawnShopId,
  //       recurringInterest: recurringInterest,
  //       repaymentTokens: repaymentTokens?.map((e) => e.toDomain()).toList(),
  //     );

  factory ItemPawnShopPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemPawnShopPackageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ItemPawnShopPackageResponseToJson(this);

  @override
  List<Object?> get props => [];
}
