import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nfts_collateral_pawn_res.g.dart';

@JsonSerializable()
class NftsCollateralPawnResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'trace-id')
  String? traceId;
  @JsonKey(name: 'data')
  List<NftsCollateralPawnItemResponse>? data;

  NftsCollateralPawnResponse(this.error, this.code, this.traceId, this.data);

  factory NftsCollateralPawnResponse.fromJson(Map<String, dynamic> json) =>
      _$NftsCollateralPawnResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class NftsCollateralPawnItemResponse extends Equatable {

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'positionItem')
  int? positionItem;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;
  @JsonKey(name: 'nftCollateral')
  NftCollateralPawnResponse? nftCollateral;


  NftsCollateralPawnItemResponse(
      this.id, this.positionItem, this.updatedAt, this.nftCollateral);

  factory NftsCollateralPawnItemResponse.fromJson(Map<String, dynamic> json) =>
      _$NftsCollateralPawnItemResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class NftCollateralPawnResponse extends Equatable {

  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'nftId')
  String? nftId;
  @JsonKey(name: 'nftStatus')
  dynamic nftStatus;
  @JsonKey(name: 'nftType')
  int? nftType;
  @JsonKey(name: 'bcNftId')
  int? bcNftId;
  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;
  @JsonKey(name: 'nftName')
  String? nftName;
  @JsonKey(name: 'borrowerWalletAddress')
  String? borrowerWalletAddress;
  @JsonKey(name: 'reputation')
  dynamic reputation;
  @JsonKey(name: 'durationTime')
  int? durationTime;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'nftAssetLocation')
  dynamic nftAssetLocation;
  @JsonKey(name: 'nftEvaluatedPrice')
  dynamic nftEvaluatedPrice;
  @JsonKey(name: 'nftEvaluatedSymbol')
  dynamic nftEvaluatedSymbol;
  @JsonKey(name: 'expectedLoanAmount')
  int? expectedLoanAmount;
  @JsonKey(name: 'expectedLoanSymbol')
  String? expectedLoanSymbol;
  @JsonKey(name: 'nftAssetTypeId')
  dynamic nftAssetTypeId;
  @JsonKey(name: 'nftAvatarCid')
  String? nftAvatarCid;
  @JsonKey(name: 'nftMediaCid')
  String? nftMediaCid;
  @JsonKey(name: 'numberOfCopies')
  int? numberOfCopies;
  @JsonKey(name: 'totalOfCopies')
  int? totalOfCopies;

  TypeNFT getTypeNft(int type) {
    if (type == 0) {
      return TypeNFT.SOFT_NFT;
    } else {
      return TypeNFT.HARD_NFT;
    }
  }

  String getPath(String avatarCid) {
    return ApiConstants.BASE_URL_IMAGE + avatarCid;
  }
  //todo khi nào checkout check lại các fill này để còn làm nft widget

  NftMarket toDomain() => NftMarket(
    marketType: MarketType.PAWN,
    name: nftName,
    image: getPath(nftAvatarCid ?? ''),
    nftId: nftId,
    typeNFT: getTypeNft(nftType ?? 0),
    totalCopies: totalOfCopies,
    numberOfCopies: numberOfCopies,
    marketId: id.toString(),
  );


  NftCollateralPawnResponse(
      this.id,
      this.nftId,
      this.nftStatus,
      this.nftType,
      this.bcNftId,
      this.bcCollateralId,
      this.nftName,
      this.borrowerWalletAddress,
      this.reputation,
      this.durationTime,
      this.durationType,
      this.nftAssetLocation,
      this.nftEvaluatedPrice,
      this.nftEvaluatedSymbol,
      this.expectedLoanAmount,
      this.expectedLoanSymbol,
      this.nftAssetTypeId,
      this.nftAvatarCid,
      this.nftMediaCid,
      this.numberOfCopies,
      this.totalOfCopies);

  factory NftCollateralPawnResponse.fromJson(Map<String, dynamic> json) =>
      _$NftCollateralPawnResponseFromJson(json);

  @override
  List<Object?> get props => [];
}
