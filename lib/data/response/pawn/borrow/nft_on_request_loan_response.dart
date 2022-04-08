import 'package:Dfy/data/response/nft/nft_on_pawn_response.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/pawn/borrow/nft_on_request_loan_model.dart';
import 'package:Dfy/domain/model/pawn/offer_sent/offer_sent_detail_cryptp_collateral_model.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_on_request_loan_response.g.dart';

@JsonSerializable()
class NftOnRequestLoanResponse extends Equatable {
  @JsonKey(name: 'error')
  String? error;
  @JsonKey(name: 'code')
  int? code;
  @JsonKey(name: 'message')
  dynamic message;
  @JsonKey(name: 'trace-id')
  String? traceId;
  @JsonKey(name: 'data')
  NftOnRequestLoanItemResponse? data;

  NftOnRequestLoanResponse({
    this.error,
    this.code,
    this.message,
    this.traceId,
    this.data,
  });

  factory NftOnRequestLoanResponse.fromJson(Map<String, dynamic> json) =>
      _$NftOnRequestLoanResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class NftOnRequestLoanItemResponse extends Equatable {
  @JsonKey(name: 'number')
  int? number;
  @JsonKey(name: 'page')
  int? page;
  @JsonKey(name: 'size')
  int? size;
  @JsonKey(name: 'number_of_elements')
  int? numberOfElements;
  @JsonKey(name: 'is_first')
  bool? isFirst;
  @JsonKey(name: 'is_last')
  bool? isLast;
  @JsonKey(name: 'has_next')
  bool? hasNext;
  @JsonKey(name: 'has_previous')
  bool? hasPrevious;
  @JsonKey(name: 'total_pages')
  int? totalPages;
  @JsonKey(name: 'total_elements')
  int? totalElements;
  @JsonKey(name: 'content')
  List<NftOnRequestLoanContentResponse>? content;

  NftOnRequestLoanItemResponse({
    this.number,
    this.page,
    this.size,
    this.numberOfElements,
    this.isFirst,
    this.isLast,
    this.hasNext,
    this.hasPrevious,
    this.totalPages,
    this.totalElements,
    this.content,
  });

  NftOnRequestLoanItemModel toModel() => NftOnRequestLoanItemModel(
        number: number,
        page: page,
        size: size,
        numberOfElements: numberOfElements,
        isFirst: isFirst,
        isLast: isLast,
        hasNext: hasNext,
        hasPrevious: hasPrevious,
        totalPages: totalPages,
        totalElements: totalElements,
        content: content?.map((e) => e.toModel()).toList(),
      );

  factory NftOnRequestLoanItemResponse.fromJson(Map<String, dynamic> json) =>
      _$NftOnRequestLoanItemResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class NftOnRequestLoanContentResponse extends Equatable {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'userId')
  int? userId;
  @JsonKey(name: 'collateralSymbol')
  String? collateralSymbol;
  @JsonKey(name: 'collateralAddress')
  String? collateralAddress;
  @JsonKey(name: 'collateralAmount')
  double? collateralAmount;
  @JsonKey(name: 'loanSymbol')
  String? loanSymbol;
  @JsonKey(name: 'loanAmount')
  dynamic loanAmount;
  @JsonKey(name: 'loanAddress')
  dynamic loanAddress;
  @JsonKey(name: 'description')
  dynamic description;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'durationType')
  int? durationType;
  @JsonKey(name: 'durationQty')
  int? durationQty;
  @JsonKey(name: 'bcCollateralId')
  int? bcCollateralId;
  @JsonKey(name: 'numberOfferReceived')
  int? numberOfferReceived;
  @JsonKey(name: 'latestBlockchainTxn')
  String? latestBlockchainTxn;
  @JsonKey(name: 'estimatePrice')
  double? estimatePrice;
  @JsonKey(name: 'expectedLoanAmount')
  double? expectedLoanAmount;
  @JsonKey(name: 'expectedCollateralSymbol')
  String? expectedCollateralSymbol;
  @JsonKey(name: 'reputation')
  int? reputation;
  @JsonKey(name: 'walletAddress')
  String? walletAddress;
  @JsonKey(name: 'completedContracts')
  int? completedContracts;
  @JsonKey(name: 'isActive')
  dynamic isActive;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'nftCollateralDetailDTO')
  NftCollateralDetailResponse? nftCollateralDetailDTO;
  @JsonKey(name: 'nft')
  NftResponse? nft;

  NftOnRequestLoanContentResponse({
    this.id,
    this.userId,
    this.collateralSymbol,
    this.collateralAddress,
    this.collateralAmount,
    this.loanSymbol,
    this.loanAmount,
    this.loanAddress,
    this.description,
    this.status,
    this.durationType,
    this.durationQty,
    this.bcCollateralId,
    this.numberOfferReceived,
    this.latestBlockchainTxn,
    this.estimatePrice,
    this.expectedLoanAmount,
    this.expectedCollateralSymbol,
    this.reputation,
    this.walletAddress,
    this.completedContracts,
    this.isActive,
    this.type,
    this.nftCollateralDetailDTO,
    this.nft,
  });

  ContentNftOnRequestLoanModel toModel() => ContentNftOnRequestLoanModel(
        id: id,
        userId: userId,
        collateralSymbol: collateralSymbol,
        collateralAmount: collateralAmount,
        loanSymbol: loanSymbol,
        status: status,
        durationType: durationType,
        durationQty: durationQty,
        bcCollateralId: bcCollateralId,
        numberOfferReceived: numberOfferReceived,
        latestBlockchainTxn: latestBlockchainTxn,
        estimatePrice: estimatePrice,
        expectedLoanAmount: expectedLoanAmount,
        expectedCollateralSymbol: expectedCollateralSymbol,
        reputation: reputation,
        walletAddress: walletAddress,
        completedContracts: completedContracts,
        type: type,
        nft: nft?.toModel(
          collateralId: id ?? 0,
          walletAddress: walletAddress ?? '',
          expectedCollateralSymbol: expectedCollateralSymbol ?? DFY,
          durationType: durationType ?? 0,
          durationQty: durationQty ?? 0,
          expectedLoanAmount: expectedLoanAmount ?? 0,
          loanSymbol: loanSymbol ?? '',
        ),
        nftCollateralDetailDTO: nftCollateralDetailDTO?.toDomain(),
      );

  OfferSentDetailCryptoCollateralModel toOfferDetailCryptoCollateral() =>
      OfferSentDetailCryptoCollateralModel(
        latestBlockchainTxn: latestBlockchainTxn,
        description: description,
        bcCollateralId: bcCollateralId,
        durationQty: durationQty,
        durationType: durationType,
        id: id,
        userId: userId,
        walletAddress: walletAddress,
        status: status,
        type: type,
        loanSymbol: loanSymbol,
        completedContracts: completedContracts,
        reputation: reputation,
        expectedCollateralSymbol: expectedCollateralSymbol,
        estimatePrice: estimatePrice,
        numberOfferReceived: numberOfferReceived,
        collateralAmount: collateralAmount,
        collateralSymbol: collateralSymbol,
      );

  factory NftOnRequestLoanContentResponse.fromJson(Map<String, dynamic> json) =>
      _$NftOnRequestLoanContentResponseFromJson(json);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class NftResponse extends Equatable {
  @JsonKey(name: 'nftId')
  String? nftId;
  @JsonKey(name: 'nftType')
  int? nftType;
  @JsonKey(name: 'nftAddress')
  dynamic nftAddress;
  @JsonKey(name: 'nftName')
  String? nftName;
  @JsonKey(name: 'expectedLoanAmount')
  dynamic expectedLoanAmount;
  @JsonKey(name: 'nftAvatarCid')
  String? nftAvatarCid;
  @JsonKey(name: 'nftMediaCid')
  String? nftMediaCid;
  @JsonKey(name: 'nftAssetTypeId')
  int? nftAssetTypeId;
  @JsonKey(name: 'nftAssetLocation')
  dynamic nftAssetLocation;
  @JsonKey(name: 'nftEvaluatedPrice')
  dynamic nftEvaluatedPrice;
  @JsonKey(name: 'nftEvaluatedSymbol')
  dynamic nftEvaluatedSymbol;
  @JsonKey(name: 'bcNftId')
  int? bcNftId;
  @JsonKey(name: 'collectionAddress')
  String? collectionAddress;
  @JsonKey(name: 'collectionName')
  String? collectionName;
  @JsonKey(name: 'isWhitelist')
  bool? isWhitelist;
  @JsonKey(name: 'assetTypeId')
  int? assetTypeId;
  @JsonKey(name: 'nftStatus')
  dynamic nftStatus;
  @JsonKey(name: 'nftAssetTypeIdRef')
  dynamic nftAssetTypeIdRef;
  @JsonKey(name: 'fileType')
  String? fileType;
  @JsonKey(name: 'numberOfCopies')
  dynamic numberOfCopies;
  @JsonKey(name: 'totalOfCopies')
  dynamic totalOfCopies;

  NftResponse({
    this.nftId,
    this.nftType,
    this.nftAddress,
    this.nftName,
    this.expectedLoanAmount,
    this.nftAvatarCid,
    this.nftMediaCid,
    this.nftAssetTypeId,
    this.nftAssetLocation,
    this.nftEvaluatedPrice,
    this.nftEvaluatedSymbol,
    this.bcNftId,
    this.collectionAddress,
    this.collectionName,
    this.isWhitelist,
    this.assetTypeId,
    this.nftStatus,
    this.nftAssetTypeIdRef,
    this.fileType,
    this.numberOfCopies,
    this.totalOfCopies,
  });

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

  TypeNFT getTypeNft(int type) {
    if (type == 0) {
      return TypeNFT.SOFT_NFT;
    } else {
      return TypeNFT.HARD_NFT;
    }
  }


  //todo cần xem lại các trường khi dùng nftmarket
  NftMarket toModel({
    required double expectedLoanAmount,
    required String loanSymbol,
    required String expectedCollateralSymbol,
    required int durationType,
    required int durationQty,
    required int collateralId,
    required String walletAddress,
  }) =>
      NftMarket(
        walletAddress: walletAddress,
        expectedCollateralSymbol: expectedCollateralSymbol,
        price: expectedLoanAmount,
        symbolToken: loanSymbol,
        collateralId: collateralId,
        name: nftName,
        nftId: nftId,
        typeNFT: getTypeNft(nftType ?? 0),
        collectionAddress: collectionAddress,
        durationQty: durationQty,
        durationType: durationType,
        collectionName: collectionName,
        isWhitelist: isWhitelist,
        image: getPath(nftAvatarCid ?? nftMediaCid ?? ''),
        cover: getPath(nftMediaCid ?? ''),
        totalCopies: (totalOfCopies ?? 0) as int,
        bcNftId: bcNftId,
        typeImage: getTypeImage(fileType ?? ''),
        numberOfCopies: (numberOfCopies ?? 0) as int,

        ///đang fix cứng theo web
        marketType: MarketType.PAWN,
      );

  factory NftResponse.fromJson(Map<String, dynamic> json) =>
      _$NftResponseFromJson(json);

  @override
  List<Object?> get props => [];
}
