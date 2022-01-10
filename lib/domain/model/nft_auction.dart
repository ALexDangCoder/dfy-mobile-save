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
  MarketType? marketStatus;
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


  NFTOnAuction({
    this.auctionId,
    this.blockchainNetwork,
    this.buyOutPrice,
    this.collectionAddress,
    this.collectionId,
    this.collectionName,
    this.coverCid,
    this.urlToken,
    this.tokenSymbol,
    this.usdExchange,
    this.currentPrice,
    this.currentWinner,
    this.description,
    this.endTime,
    this.fileCid,
    this.typeImage,
    this.id,
    this.idRef,
    this.isBidByOther,
    this.isBidProcessing,
    this.isBoughtByOther,
    this.isOwner,
    this.marketStatus,
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
  });
}

class Properties {
  String? key;
  String? value;

  Properties(this.key, this.value);
}
