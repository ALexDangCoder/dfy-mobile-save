import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_on_auction_response.g.dart';

@JsonSerializable()
class AuctionResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'item')
  DetailAuctionResponse? item;

  AuctionResponse(this.rc, this.rd, this.item);

  factory AuctionResponse.fromJson(Map<String, dynamic> json) =>
      _$AuctionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuctionResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DetailAuctionResponse {
  @JsonKey(name: 'auction_id')
  int? auctionId;
  @JsonKey(name: 'blockchain_network')
  String? blockchainNetwork;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'buy_out_price')
  double? buyOutPrice;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'collection_name')
  String? collectionName;
  @JsonKey(name: 'collection_id')
  String? collectionId;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'current_price')
  double? currentPrice;
  @JsonKey(name: 'current_winner')
  String? currentWinner;
  @JsonKey(name: 'end_time')
  int? endTime;
  @JsonKey(name: 'file_cid')
  String? fileCid;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'id_ref')
  String? idRef;
  @JsonKey(name: 'is_bid_by_others')
  bool? isBidByOthers;
  @JsonKey(name: 'is_bid_processing')
  bool? isBidProcessing;
  @JsonKey(name: 'is_bought_by_other')
  bool? isBoughtByOther;
  @JsonKey(name: 'is_owner')
  bool? isOwner;
  @JsonKey(name: 'like')
  int? like;
  @JsonKey(name: 'market_status')
  int? marketStatus;
  @JsonKey(name: 'market_type')
  int? marketType;
  @JsonKey(name: 'media_cid')
  String? mediaCid;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'nft_cid')
  String? nftCid;
  @JsonKey(name: 'nft_standard')
  String? nftStandard;
  @JsonKey(name: 'nft_token_id')
  String? nftTokenId;
  @JsonKey(name: 'number_bid')
  int? numberBid;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'owner')
  String? owner;
  @JsonKey(name: 'owner_account')
  String? ownerAccount;
  @JsonKey(name: 'price_step')
  double? priceStep;
  @JsonKey(name: 'reserve_price')
  double? reservePrice;
  @JsonKey(name: 'show')
  bool? show;
  @JsonKey(name: 'start_time')
  int? startTime;
  @JsonKey(name: 'ticked')
  bool? ticked;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'total_copies')
  int? totalCopies;
  @JsonKey(name: 'txn_hash')
  String? txnHash;
  @JsonKey(name: 'type')
  String? type;
  @JsonKey(name: 'view')
  int? view;
  @JsonKey(name: 'properties')
  List<PropertiesResponse>? properties;

  DetailAuctionResponse(
    this.auctionId,
    this.blockchainNetwork,
    this.description,
    this.buyOutPrice,
    this.collectionAddress,
    this.collectionId,
    this.coverCid,
    this.currentPrice,
    this.currentWinner,
    this.endTime,
    this.fileCid,
    this.fileType,
    this.id,
    this.idRef,
    this.isBidByOthers,
    this.isBidProcessing,
    this.isBoughtByOther,
    this.isOwner,
    this.like,
    this.marketStatus,
    this.marketType,
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
    this.reservePrice,
    this.show,
    this.startTime,
    this.ticked,
    this.token,
    this.totalCopies,
    this.txnHash,
    this.type,
    this.view,
  );

  factory DetailAuctionResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailAuctionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailAuctionResponseToJson(this);

  List<Object?> get props => [];

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

  NFTOnAuction toAuction() => NFTOnAuction(
        auctionId: auctionId,
        blockchainNetwork: blockchainNetwork,
        buyOutPrice: buyOutPrice,
        collectionAddress: collectionAddress,
        collectionId: collectionId,
        collectionName: collectionName,
        coverCid: coverCid,
        currentPrice: currentPrice,
        currentWinner: currentWinner,
        description: description,
        endTime: endTime,
        fileCid: getPath(fileCid ?? ''),
        typeImage: getTypeImage(fileType ?? ''),
        id: id,
        idRef: idRef,
        isBidByOther: isBidByOthers,
        isBidProcessing: isBidProcessing,
        isBoughtByOther: isBoughtByOther,
        isOwner: isOwner,
        marketStatus: getTypeMarket(marketStatus ?? 2),
        mediaCid: mediaCid,
        name: name,
        nftCid: nftCid,
        nftStandard: nftStandard,
        nftTokenId: nftTokenId,
        numberBid: numberBid,
        numberOfCopies: numberOfCopies,
        owner: owner,
        ownerAccount: ownerAccount,
        priceStep: priceStep,
        properties: properties?.map((e) => e.toDomain()).toList(),
        reservePrice: reservePrice,
        show: show,
        startTime: startTime,
        ticked: ticked,
        token: token,
        totalCopies: totalCopies,
        txnHash: txnHash,
        type: type,
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
