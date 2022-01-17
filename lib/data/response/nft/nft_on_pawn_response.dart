import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_on_pawn_response.g.dart';

@JsonSerializable()
class OnPawnResponse extends Equatable {
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'data')
  DetailOnPawnResponse? data;

  OnPawnResponse(this.code, this.message, this.data);

  factory OnPawnResponse.fromJson(Map<String, dynamic> json) =>
      _$OnPawnResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OnPawnResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DetailOnPawnResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'collateralSymbol')
  String? collateralSymbol;
  @JsonKey(name: 'collateralAmount')
  double? collateralAmount;
  @JsonKey(name: 'loanSymbol')
  String? loanSymbol;
  @JsonKey(name: 'loanAmount')
  double? loanAmount;
  @JsonKey(name: 'loanAddress')
  String? loanAddress;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'durationQty')
  int? durationQuantity;
  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;
  @JsonKey(name: 'numberOfferReceived')
  int? numberOfferReceived;
  @JsonKey(name: 'latestBlockChainTxn')
  String? latestBlockChainTxn;
  @JsonKey(name: 'estimatePrice')
  double? estimatePrice;
  @JsonKey(name: 'expectedCollateralSymbol')
  String? expectedCollateralSymbol;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'completeContracts')
  num? completeContracts;
  @JsonKey(name: 'isActive')
  bool? isActive;
  @JsonKey(name: 'expectedLoanAmount')
  double? expectedLoanAmount;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'nftCollateralDetailDTO')
  NftCollateralDetailResponse? nftCollateralDetailDTO;

  DetailOnPawnResponse(
    this.id,
    this.userId,
    this.collateralSymbol,
    this.collateralAmount,
    this.loanSymbol,
    this.loanAmount,
    this.loanAddress,
    this.description,
    this.status,
    this.durationType,
    this.durationQuantity,
    this.bcCollateralId,
    this.numberOfferReceived,
    this.latestBlockChainTxn,
    this.estimatePrice,
    this.expectedCollateralSymbol,
    this.reputation,
    this.walletAddress,
    this.completeContracts,
    this.isActive,
    this.type,
    this.nftCollateralDetailDTO,
  );

  factory DetailOnPawnResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailOnPawnResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailOnPawnResponseToJson(this);

  List<Object?> get props => [];

  NftOnPawn toOnPawn() => NftOnPawn(
        id: id,
        userId: userId,
        description: description,
        status: status,
        durationType: durationType,
        durationQuantity: durationQuantity,
        bcCollateralId: bcCollateralId,
        numberOfferReceived: numberOfferReceived,
        latestBlockChainTxn: latestBlockChainTxn,
        estimatePrice: estimatePrice,
        expectedLoanAmount: expectedLoanAmount,
        expectedCollateralSymbol: expectedCollateralSymbol,
        reputation: reputation,
        walletAddress: walletAddress,
        completeContracts: completeContracts,
        isActive: isActive,
        nftCollateralDetailDTO: nftCollateralDetailDTO!.toDomain(),
      );
}

@JsonSerializable()
class NftCollateralDetailResponse {
  @JsonKey(name: 'nftId')
  String? nftId;
  @JsonKey(name: 'nftTokenId')
  int? nftTokenId;
  @JsonKey(name: 'networkName')
  String? networkName;
  @JsonKey(name: 'nftType')
  int? typeNFT;
  @JsonKey(name: 'nftStandard')
  int? nftStandard;
  @JsonKey(name: 'nftMediaType')
  String? typeImage;
  @JsonKey(name: 'nftMediaCid')
  String? image;
  @JsonKey(name: 'nftAvatarCid')
  String? nftAvatarCid;
  @JsonKey(name: 'nftName')
  String? nftName;
  @JsonKey(name: 'collectionAddress')
  String? collectionAddress;
  @JsonKey(name: 'collectionName')
  String? nameCollection;
  @JsonKey(name: 'isWhitelist')
  bool? isWhitelist;
  @JsonKey(name: 'numberOfCopies')
  int? numberOfCopies;
  @JsonKey(name: 'totalOfCopies')
  int? totalCopies;
  @JsonKey(name: 'evaluationId')
  String? evaluationId;
  @JsonKey(name: 'properties')
  List<PropertiesResponse>? propertiesResponse;

  NftCollateralDetailResponse(
    this.nftId,
    this.nftTokenId,
    this.networkName,
    this.typeNFT,
    this.nftStandard,
    this.typeImage,
    this.image,
    this.nftAvatarCid,
    this.nftName,
    this.collectionAddress,
    this.nameCollection,
    this.isWhitelist,
    this.numberOfCopies,
    this.totalCopies,
    this.evaluationId,
    this.propertiesResponse,
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

  TypeNFT getTypeNft(int type) {
    if (type == 0) {
      return TypeNFT.SOFT_NFT;
    } else {
      return TypeNFT.HARD_NFT;
    }
  }

  MarketType getTypeMarket(int type) {
    if (type == 2) {
      return MarketType.AUCTION;
    } else if (type == 3) {
      return MarketType.PAWN;
    } else {
      return MarketType.SALE;
    }
  }

  factory NftCollateralDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$NftCollateralDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NftCollateralDetailResponseToJson(this);

  NftCollateralDetailDTO toDomain() => NftCollateralDetailDTO(
        nftId: nftId,
        nftTokenId: nftTokenId,
        networkName: networkName,
        typeNFT: getTypeNft(typeNFT ?? 0),
        nftStandard: nftStandard,
        typeImage: getTypeImage(typeImage ?? 'image'),
        nftAvatarCid: nftAvatarCid,
        nftName: nftName,
        collectionAddress: collectionAddress,
        nameCollection: nameCollection,
        isWhitelist: isWhitelist,
        totalCopies: totalCopies,
        numberOfCopies: numberOfCopies,
        evaluationId: evaluationId,
        image: getPath(
          (getTypeImage(typeImage ?? 'image') == TypeImage.IMAGE)
              ? (image != '' ? (image ?? ''):(nftAvatarCid ?? ''))
              : (nftAvatarCid ?? ''),
        ),
        properties: propertiesResponse?.map((e) => e.toDomain()).toList(),
      );
}

@JsonSerializable()
class PropertiesResponse {
  @JsonKey(name: 'key')
  String key;
  @JsonKey(name: 'value')
  String value;

  PropertiesResponse(this.key, this.value);

  factory PropertiesResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesResponseToJson(this);

  Properties toDomain() => Properties(key, value);
}
