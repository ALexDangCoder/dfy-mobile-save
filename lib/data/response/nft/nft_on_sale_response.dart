import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_on_sale_response.g.dart';

@JsonSerializable()
class OnSaleResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'item')
  DetailOnSaleResponse? item;

  OnSaleResponse(this.rc, this.rd, this.item);

  factory OnSaleResponse.fromJson(Map<String, dynamic> json) =>
      _$OnSaleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OnSaleResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DetailOnSaleResponse {
  @JsonKey(name: 'id')
  String? marketId;
  @JsonKey(name: 'type')
  String nftType;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'price')
  double price;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'ticked')
  bool? ticked;
  @JsonKey(name: 'owner')
  String? owner;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'file_cid')
  String fileCid;
  @JsonKey(name: 'market_type')
  int marketType;
  @JsonKey(name: 'market_status')
  int? marketStatus;
  @JsonKey(name: 'estimated_price')
  double? estimatedPrice;
  @JsonKey(name: 'collection_id')
  String? collectionId;
  @JsonKey(name: 'collection_name')
  String? collectionName;
  @JsonKey(name: 'is_owner')
  bool? isOwner;
  @JsonKey(name: 'nft_standard')
  String? nftStandard;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'total_copies')
  int? totalCopies;
  @JsonKey(name: 'market_fee')
  double? marketFee;
  @JsonKey(name: 'royalties')
  double? royalties;
  @JsonKey(name: 'order_id')
  int? orderId;
  @JsonKey(name: 'id_ref')
  String? idRef;
  @JsonKey(name: 'is_bought_by_other')
  bool? isBoughtByOther;
  @JsonKey(name: 'file_type')
  String fileType;
  @JsonKey(name: 'txn_hash')
  String? txnHash;
  @JsonKey(name: 'owner_account')
  String? ownerAccount;
  @JsonKey(name: 'blockchain_network')
  String? blockChainNetwork;
  @JsonKey(name: 'nft_token_id')
  String? nftTokenId;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'properties')
  List<PropertiesResponse>? properties;

  DetailOnSaleResponse(
    this.marketId,
    this.nftType,
    this.name,
    this.price,
    this.token,
    this.ticked,
    this.owner,
    this.isBoughtByOther,
    this.description,
    this.fileCid,
    this.marketType,
    this.estimatedPrice,
    this.collectionId,
    this.collectionName,
    this.isOwner,
    this.nftStandard,
    this.numberOfCopies,
    this.totalCopies,
    this.marketFee,
    this.royalties,
    this.orderId,
    this.idRef,
    this.fileType,
    this.txnHash,
    this.ownerAccount,
    this.blockChainNetwork,
    this.nftTokenId,
    this.collectionAddress,
    this.properties,
  );

  factory DetailOnSaleResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailOnSaleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailOnSaleResponseToJson(this);

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

  TypeNFT getTypeNft(String type) {
    if (type == '0') {
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

  int getBool(bool? check) {
    if (check ?? true) {
      return 1;
    } else {
      return 0;
    }
  }

  NftMarket toOnSale() => NftMarket(
        marketId: marketId,
        typeNFT: getTypeNft(nftType),
        name: name,
        price: price,
        token: token,
        tokenBuyOut: token,
        ticked: getBool(ticked),
        owner: owner,
        description: description,
        properties: properties?.map((e) => e.toDomain()).toList(),
        image: getPath(fileCid),
        marketType: getTypeMarket(marketType),
        estimatePrice: estimatedPrice,
        collectionID: collectionId,
        collectionName: collectionName,
        isOwner: isOwner,
        marketStatus: marketStatus,
        nftStandard: nftStandard,
        numberOfCopies: numberOfCopies,
        totalCopies: totalCopies,
        marketFee: marketFee,
        isBoughtByOther: isBoughtByOther,
        royalties: royalties,
        typeImage: getTypeImage(fileType),
        txnHash: txnHash,
        orderId: orderId,
        ownerAccount: ownerAccount,
        blockchainNetwork: blockChainNetwork,
        nftTokenId: nftTokenId,
        collectionAddress: collectionAddress,
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
