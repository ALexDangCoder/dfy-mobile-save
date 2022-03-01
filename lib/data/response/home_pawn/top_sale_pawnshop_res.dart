import 'package:Dfy/data/response/home_pawn/official_pawn_with_token_res.dart';
import 'package:Dfy/domain/model/home_pawn/loan_token_model.dart';
import 'package:Dfy/domain/model/home_pawn/pawn_shop_package_model.dart';
import 'package:Dfy/domain/model/home_pawn/top_sale_pawnshop_item_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'top_sale_pawnshop_res.g.dart';

@JsonSerializable()
class TopSalePawnShopPackageResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'trace-id')
  String? traceId;
  @JsonKey(name: 'data')
  List<TopSalePawnShopItemResponse>? data;

  TopSalePawnShopPackageResponse(
      this.error, this.code, this.traceId, this.data);

  factory TopSalePawnShopPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$TopSalePawnShopPackageResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class TopSalePawnShopItemResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'signedContract')
  int? signedContract;
  @JsonKey(name: 'positionItem')
  int? positionItem;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'pawnShopPackage')
  PawnShopPackageResponse? pawnShopPackage;

  TopSalePawnShopItemResponse(
    this.id,
    this.signedContract,
    this.positionItem,
    this.updatedAt,
    this.pawnShopPackage,
  );

  TopSalePawnShopItemModel toModel() => TopSalePawnShopItemModel(
        id: id,
        positionItem: positionItem,
        updatedAt: updatedAt,
        pawnShopPackage: pawnShopPackage?.toModel(),
        signedContract: signedContract,
      );

  factory TopSalePawnShopItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TopSalePawnShopItemResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class PawnShopPackageResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'pawnShop')
  PawnShopResponse? pawnShop;
  @JsonKey(name: 'allowedLoanMax')
  int? allowedLoanMax;
  @JsonKey(name: 'allowedLoanMin')
  double? allowedLoanMin;
  @JsonKey(name: 'interest')
  dynamic interest;
  @JsonKey(name: 'interestMin')
  int? interestMin;
  @JsonKey(name: 'interestMax')
  int? interestMax;
  @JsonKey(name: 'loanToken')
  LoanTokenResponse? loanToken;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'status')
  int? status;


  PawnShopPackageResponse(
      this.id,
      this.name,
      this.pawnShop,
      this.allowedLoanMax,
      this.allowedLoanMin,
      this.interest,
      this.interestMin,
      this.interestMax,
      this.loanToken,
      this.type,
      this.status);

  factory PawnShopPackageResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnShopPackageResponseFromJson(json);

  PawnShopPackageModel toModel() => PawnShopPackageModel(
        name: name,
        id: id,
        pawnShop: pawnShop?.toModel(),
        type: type,
        allowedLoanMax: allowedLoanMax,
        allowedLoanMin: allowedLoanMin,
        interestMax: interestMax,
        interestMin: interestMin,
        loanToken: loanToken?.toModel(),
        status: status,
      );

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class LoanTokenResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'createdAt')
  dynamic createdAt;
  @JsonKey(name: 'updatedAt')
  dynamic updatedAt;
  @JsonKey(name: 'isDeleted')
  dynamic isDeleted;
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'isWhitelistCollateral')
  bool? isWhitelistCollateral;
  @JsonKey(name: 'isWhitelistSupply')
  bool? isWhitelistSupply;
  @JsonKey(name: 'coinGeckoId')
  String? coinGeckoId;
  @JsonKey(name: 'whitelistAsset')
  bool? whitelistAsset;
  @JsonKey(name: 'isApplyVesting')
  bool? isApplyVesting;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'iconUrl')
  String? iconUrl;
  @JsonKey(name: 'isExchangeMiles')
  bool? isExchangeMiles;

  LoanTokenResponse(
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.symbol,
    this.address,
    this.isWhitelistCollateral,
    this.isWhitelistSupply,
    this.coinGeckoId,
    this.whitelistAsset,
    this.isApplyVesting,
    this.name,
    this.iconUrl,
    this.isExchangeMiles,
  );

  factory LoanTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$LoanTokenResponseFromJson(json);

  LoanTokenModel toModel() => LoanTokenModel(
        id: id,
        address: address,
        isWhitelistSupply: isWhitelistSupply,
        isWhitelistCollateral: isWhitelistCollateral,
        symbol: symbol,
        name: name,
        coinGeckoId: coinGeckoId,
        iconUrl: iconUrl,
        isApplyVesting: isApplyVesting,
        isExchangeMiles: isExchangeMiles,
        whitelistAsset: whitelistAsset,
      );

  @override
  List<Object?> get props => [];
}
