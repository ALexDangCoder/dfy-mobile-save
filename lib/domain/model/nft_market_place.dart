import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/utils/constants/app_constants.dart';

class NftMarket {
  String? nftId;
  String? marketId;
  String? name;
  String? token;
  String? image;
  double? price;
  String? tokenBuyOut;
  double? reservePrice;
  double? buyOutPrice;
  double? estimatePrice;
  MarketType? marketType;
  TypeNFT? typeNFT;
  TypeImage? typeImage;
  int? startTime;
  int? endTime;
  String? urlToken;
  String? symbolToken;
  double? usdExchange;
  int? numberOfCopies;
  int? totalCopies;
  int? ticked;
  String? owner;
  String? collectionID;
  String? collectionName;
  int? isOwner;
  String? nftStandard;
  double? marketFee;
  double? royalties;
  String? nftTokenId;
  String? collectionAddress;
  String? description;
  String? txnHash;
  int? orderId;
  String? ownerAccount;
  String? blockchainNetwork;
  List<Properties>? properties;
  int? countProperties;
  double? mintingFeeNumber;
  String? mintingFeeToken;
  int? createAt;
  int? updateAt;
  String? evaluationId;
  bool? isWhitelist;
  int? pawnId;

  NftMarket.init();

  NftMarket({
    this.token,
    this.nftId,
    this.tokenBuyOut,
    this.name,
    this.image,
    this.price,
    this.marketType,
    this.pawnId,
    this.typeNFT,
    this.typeImage,
    this.ticked,
    this.marketId,
    this.reservePrice,
    this.urlToken,
    this.symbolToken,
    this.usdExchange,
    this.buyOutPrice,
    this.numberOfCopies,
    this.totalCopies,
    this.endTime = 0,
    this.startTime = 0,
    this.estimatePrice,
    this.owner,
    this.orderId,
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
    this.countProperties,
    this.updateAt,
    this.createAt,
    this.evaluationId,
    this.isWhitelist,
    this.mintingFeeToken,
    this.mintingFeeNumber,
  });
}
