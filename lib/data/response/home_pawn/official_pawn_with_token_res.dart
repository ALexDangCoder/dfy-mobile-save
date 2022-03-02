import 'package:Dfy/domain/model/home_pawn/crypto_asset_model.dart';
import 'package:Dfy/domain/model/home_pawn/official_pawn_item_model.dart';
import 'package:Dfy/domain/model/home_pawn/official_pawn_with_token_model.dart';
import 'package:Dfy/domain/model/home_pawn/pawn_shop_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'official_pawn_with_token_res.g.dart';

@JsonSerializable()
class OfficialPawnWithNewTokenResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'trace-id')
  String? traceId;
  @JsonKey(name: 'data')
  List<OfficialPawnItemResponse>? data;

  OfficialPawnWithNewTokenResponse(
      this.error, this.code, this.traceId, this.data);

  OfficialPawnWithTokenModel toModel() => OfficialPawnWithTokenModel(
      listOfficialPawnItem: data?.map((e) => e.toModel()).toList());

  factory OfficialPawnWithNewTokenResponse.fromJson(
          Map<String, dynamic> json) =>
      _$OfficialPawnWithNewTokenResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class OfficialPawnItemResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'positionItem')
  int? positionItem;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'imageCryptoAsset')
  String? imageCryptoAsset;
  @JsonKey(name: 'cryptoAsset')
  CryptoAssetResponse? cryptoAsset;
  @JsonKey(name: 'pawnShop')
  PawnShopResponse? pawnShop;

  @override
  List<Object?> get props => [];

  OfficialPawnItemResponse(this.id, this.positionItem, this.updatedAt,
      this.imageCryptoAsset, this.cryptoAsset, this.pawnShop);

  OfficialPawnItemModel toModel() => OfficialPawnItemModel(
        id: id,
        cryptoAsset: cryptoAsset?.toModel(),
        pawnShop: pawnShop?.toModel(),
        imageCryptoAsset: imageCryptoAsset,
        positionItem: positionItem,
        updatedAt: updatedAt,
      );

  factory OfficialPawnItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OfficialPawnItemResponseFromJson(json);
}

@JsonSerializable()
class CryptoAssetResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'createdAt')
  dynamic createdAt;
  @JsonKey(name: 'updatedAt')
  dynamic updatedAt;
  @JsonKey(name: 'isDeleted')
  dynamic imageCryptoAsset;
  @JsonKey(name: 'symbol')
  String? symbol;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'isWhitelistCollateral')
  bool? isWhitelistCollateral;
  @JsonKey(name: 'isWhitelistSupply')
  bool? isWhitelistSupply;

  factory CryptoAssetResponse.fromJson(Map<String, dynamic> json) =>
      _$CryptoAssetResponseFromJson(json);

  CryptoAssetResponse(
      this.id,
      this.createdAt,
      this.updatedAt,
      this.imageCryptoAsset,
      this.symbol,
      this.address,
      this.isWhitelistCollateral,
      this.isWhitelistSupply);

  CryptoAssetModel toModel() => CryptoAssetModel(
        id: id,
        address: address,
        symbol: symbol,
        isWhitelistCollateral: isWhitelistCollateral,
        isWhitelistSupply: isWhitelistSupply,
      );

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class PawnShopResponse extends Equatable {
  @JsonKey(name: 'pawnShopType')
  dynamic pawnShopType;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name: 'address')
  String? address;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'avatar')
  dynamic avatar;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'isFeaturedPawnshop')
  dynamic isFeaturedPawnshop;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'rank')
  dynamic rank;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'signedContracts')
  dynamic signedContracts;
  @JsonKey(name: 'handingTime')
  dynamic handingTime;
  @JsonKey(name: 'createdAt')
  dynamic createdAt;
  @JsonKey(name: 'updatedAt')
  dynamic updatedAt;
  @JsonKey(name: 'isKYC')
  dynamic isKYC;

  factory PawnShopResponse.fromJson(Map<String, dynamic> json) =>
      _$PawnShopResponseFromJson(json);

  PawnShopResponse(
    this.pawnShopType,
    this.id,
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.description,
    this.avatar,
    this.reputation,
    this.isFeaturedPawnshop,
    this.type,
    this.rank,
    this.walletAddress,
    this.signedContracts,
    this.handingTime,
    this.createdAt,
    this.updatedAt,
    this.isKYC,
  );

  PawnShopModel toModel() => PawnShopModel(
        id: id,
        type: type,
        name: name,
        reputation: reputation,
        userId: userId,
        address: address,
        walletAddress: walletAddress,
        email: email,
        description: description,
        phoneNumber: phoneNumber,
        avatar: avatar as String,
      );

  @override
  List<Object?> get props => [];
}
