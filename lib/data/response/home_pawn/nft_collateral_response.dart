import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_collateral_response.g.dart';

@JsonSerializable()
class CollateralNFTResponse {
  @JsonKey(name: 'data')
  CollateralNFTDataResponse? data;

  CollateralNFTResponse(
    this.data,
  );

  factory CollateralNFTResponse.fromJson(Map<String, dynamic> json) =>
      _$CollateralNFTResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CollateralNFTResponseToJson(this);
}

@JsonSerializable()
class CollateralNFTDataResponse {
  @JsonKey(name: 'content')
  List<ContentResponse>? content;

  CollateralNFTDataResponse(
    this.content,
  );

  factory CollateralNFTDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CollateralNFTDataResponseFromJson(json);
}

@JsonSerializable()
class ContentResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'nftId')
  String? nftId;
  @JsonKey(name: 'nftStatus')
  int? nftStatus;
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
  int? reputation;
  @JsonKey(name: 'durationTime')
  int? durationTime;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'nftAssetLocation')
  String? nftAssetLocation;
  @JsonKey(name: 'nftEvaluatedPrice')
  double? nftEvaluatedPrice;
  @JsonKey(name: 'nftEvaluatedSymbol')
  String? nftEvaluatedSymbol;
  @JsonKey(name: 'expectedLoanAmount')
  double? expectedLoanAmount;
  @JsonKey(name: 'expectedLoanSymbol')
  String? expectedLoanSymbol;
  @JsonKey(name: 'nftAssetTypeId')
  int? nftAssetTypeId;
  @JsonKey(name: 'nftAvatarCid')
  String? nftAvatarCid;
  @JsonKey(name: 'nftMediaCid')
  String? nftMediaCid;
  @JsonKey(name: 'numberOfCopies')
  int? numberOfCopies;
  @JsonKey(name: 'totalOfCopies')
  int? totalOfCopies;
  @JsonKey(name: 'mediaType')
  String? mediaType;
  @JsonKey(name: 'urlToken')
  String? urlToken;

  factory ContentResponse.fromJson(Map<String, dynamic> json) =>
      _$ContentResponseFromJson(json);

  ContentResponse(
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
    this.totalOfCopies,
    this.mediaType,
    this.urlToken,
  );

  String getPath(String avatarCid) {
    return ApiConstants.BASE_URL_IMAGE + avatarCid;
  }

  TypeImage getTypeImage(String type) {
    if (type.toLowerCase().contains('image')) {
      return TypeImage.IMAGE;
    } else {
      return TypeImage.VIDEO;
    }
  }

  MarketType getTypeMarket(int type) {
    if (type == 2) {
      return MarketType.AUCTION;
    } else if (type == 3) {
      return MarketType.PAWN;
    } else if (type == 1) {
      return MarketType.SALE;
    } else {
      return MarketType.NOT_ON_MARKET;
    }
  }

  String getNftStandard(dynamic nftStandard) {
    if (nftStandard == 'ERC_1155') {
      return '1';
    } else {
      return '0';
    }
  }

  TypeNFT getTypeNft(int type) {
    if (type == 0) {
      return TypeNFT.SOFT_NFT;
    } else {
      return TypeNFT.HARD_NFT;
    }
  }

  NftMarket toDomain() => NftMarket(
        marketType: getTypeMarket(3),
        typeImage: getTypeImage(mediaType ?? 'image'),
        cover: getPath(nftMediaCid ?? ''),
        typeNFT: getTypeNft(nftType ?? 0),
        image: getPath(nftAvatarCid ?? ''),
        nftId: nftId,
        price: expectedLoanAmount,
        name: nftName,
        tokenBuyOut: expectedLoanSymbol,
        pawnId: id ?? 0,
        totalCopies: totalOfCopies,
        numberOfCopies: numberOfCopies,
        walletAddress: borrowerWalletAddress,
      );
}
