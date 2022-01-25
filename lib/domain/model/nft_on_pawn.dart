import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/utils/constants/app_constants.dart';

class NftOnPawn {
  int? id;
  int? userId;
  String? collateralSymbol;
  double? collateralAmount;
  String? loanSymbol;
  double? loanAmount;
  String? loanAddress;
  String? description;
  int? status;
  String? urlToken;
  double? usdExchange;
  int? durationType;
  int? durationQuantity;
  int? bcCollateralId;
  int? numberOfferReceived;
  String? latestBlockChainTxn;
  double? estimatePrice;
  double? expectedLoanAmount;
  String? expectedCollateralSymbol;
  int? reputation;
  String? walletAddress;
  num? completeContracts;
  bool? isActive;
  int? type;
  bool? isYou;
  NftCollateralDetailDTO? nftCollateralDetailDTO;

  NftOnPawn({
    this.id,
    this.userId,
    this.collateralSymbol,
    this.collateralAmount,
    this.expectedLoanAmount,
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
    this.isYou,
  });
}

class NftCollateralDetailDTO {
  String? nftId;
  int? nftTokenId;
  String? networkName;
  TypeNFT? typeNFT;
  int? nftStandard;
  TypeImage? typeImage;
  String? image;
  String? nftAvatarCid;
  String? nftName;
  String? collectionAddress;
  String? nameCollection;
  bool? isWhitelist;
  int? numberOfCopies;
  int? totalCopies;
  String? evaluationId;
  List<Properties>? properties;

  NftCollateralDetailDTO({
    this.nftId,
    this.properties,
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
  });
}
