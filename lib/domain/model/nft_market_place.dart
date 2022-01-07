import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/utils/constants/app_constants.dart';

class NftMarket {
  final String? nftId;
  final String? marketId;
  final String? token;
  final String name;
  final String image;
  final double price;
  final String? tokenBuyOut;
  final double? reservePrice;
  final double? buyOutPrice;
  final double? estimatePrice;
  final MarketType marketType;
  final TypeNFT typeNFT;
  final TypeImage typeImage;
  final int? startTime;
  final int? endTime;
  final int? numberOfCopies;
  final int? totalCopies;
  final int? ticked;
  final String? owner;
  final String? collectionID;
  final String? collectionName;
  final int? isOwner;
  final String? nftStandard;
  final double? marketFee;
  final double? royalties;
  final String? nftTokenId;
  final String? collectionAddress;
  final String? description;
  final String? txnHash;
  final String? ownerAccount;
  final String? blockchainNetwork;
  final List<Properties>? properties;

  NftMarket({
    this.token,
    this.nftId,
    this.tokenBuyOut,
    required this.name,
    required this.image,
    required this.price,
    required this.marketType,
    required this.typeNFT,
    required this.typeImage,
    this.ticked,
    this.marketId,
    this.reservePrice,
    this.buyOutPrice,
    this.numberOfCopies,
    this.totalCopies,
    this.endTime = 0,
    this.startTime = 0,
    this.estimatePrice,
    this.owner,
    this.blockchainNetwork,
    this.ownerAccount,
    this.collectionID,
    this.collectionName,
    this.isOwner,
    this.nftStandard,
    this.marketFee,
    this.royalties,
    this.txnHash,
    this.nftTokenId,
    this.collectionAddress,
    this.description,
    this.properties,
  });
}
