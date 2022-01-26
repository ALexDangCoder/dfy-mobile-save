import 'package:Dfy/utils/constants/app_constants.dart';

class NFTOnAuction {
  int? auctionId;
  String? blockchainNetwork;
  double? buyOutPrice;
  String? collectionAddress;
  String? collectionId;
  String? collectionName;
  String? coverCid;
  double? currentPrice;
  String? currentWinner;
  String? description;
  int? endTime;
  String? fileCid;
  TypeImage? typeImage;
  String? id;
  String? idRef;
  bool? isBidByOther;
  bool? isBidProcessing;
  bool? isBoughtByOther;
  bool? isOwner;
  MarketType? marketType;
  int? marketStatus;
  String? mediaCid;
  String? name;
  String? nftCid;
  String? nftStandard;
  String? nftTokenId;
  int? numberBid;
  int? numberOfCopies;
  String? owner;
  String? ownerAccount;
  double? priceStep;
  List<Properties>? properties;
  double? reservePrice;
  bool? show;
  int? startTime;
  bool? ticked;
  String? token;
  int? totalCopies;
  String? txnHash;
  String? type;
  String? urlToken;
  String? tokenSymbol;
  double? usdExchange;
  int? countProperties;
  double? royalties;
  double? mintingFeeNumber;
  String? mintingFeeToken;
  int? createAt;
  int? updateAt;
  String? evaluationId;
  bool? isWhitelist;
  String? marketId;

  NFTOnAuction.init();

  NFTOnAuction({
    this.auctionId,
    this.marketId,
    this.blockchainNetwork,
    this.buyOutPrice,
    this.collectionAddress,
    this.marketType,
    this.marketStatus,
    this.collectionId,
    this.collectionName,
    this.coverCid,
    this.urlToken,
    this.tokenSymbol,
    this.usdExchange,
    this.currentPrice,
    this.currentWinner,
    this.description,
    this.countProperties,
    this.endTime,
    this.royalties,
    this.fileCid,
    this.typeImage,
    this.id,
    this.idRef,
    this.isBidByOther,
    this.isBidProcessing,
    this.isBoughtByOther,
    this.isOwner,
    this.mediaCid,
    this.name,
    this.nftCid,
    this.nftStandard,
    this.nftTokenId,
    this.numberBid,
    this.numberOfCopies,
    this.owner,
    this.ownerAccount,
    this.priceStep,
    this.properties,
    this.reservePrice,
    this.show,
    this.startTime,
    this.ticked,
    this.token,
    this.totalCopies,
    this.txnHash,
    this.type,
    this.mintingFeeNumber,
    this.mintingFeeToken,
    this.createAt,
    this.updateAt,
    this.evaluationId,
    this.isWhitelist,
  });
}

class Properties {
  String? key;
  String? value;

  Properties(this.key, this.value);
}
