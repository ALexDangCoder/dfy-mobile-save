import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hard_nft_respone.g.dart';

@JsonSerializable()
class HardNftResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'item')
  DetailHardNftResponse? item;

  HardNftResponse(this.rc, this.rd, this.item);

  factory HardNftResponse.fromJson(Map<String, dynamic> json) =>
      _$HardNftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HardNftResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DetailHardNftResponse {
  @JsonKey(name: 'id')
  String? marketId;
  @JsonKey(name: 'status')
  int? nftType;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'count_properties')
  int? countProperties;
  @JsonKey(name: 'owner')
  String? owner;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'file_cid')
  String? fileCid;
  @JsonKey(name: 'market_type')
  int? marketType;
  @JsonKey(name: 'collection_id')
  String? collectionId;
  @JsonKey(name: 'collection_name')
  String? collectionName;
  @JsonKey(name: 'nft_standard')
  dynamic nftStandard;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'minting_fee_number')
  double? mintingFeeNumber;
  @JsonKey(name: 'minting_fee_token')
  String? mintingFeeToken;
  @JsonKey(name: 'create_at')
  int? createAt;
  @JsonKey(name: 'update_at')
  int? updateAt;
  @JsonKey(name: 'royalties')
  double? royalties;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'txn_hash')
  String? txnHash;
  @JsonKey(name: 'blockchain_network')
  int? blockChainNetwork;
  @JsonKey(name: 'nft_token_id')
  int? nftTokenId;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'evaluation_id')
  String? evaluationId;
  @JsonKey(name: 'is_white_list')
  bool? isWhiteList;
  @JsonKey(name: 'properties')
  List<PropertiesResponse>? properties;

  DetailHardNftResponse(
    this.marketId,
    this.nftType,
    this.name,
    this.countProperties,
    this.owner,
    this.description,
    this.fileCid,
    this.marketType,
    this.collectionId,
    this.collectionName,
    this.nftStandard,
    this.numberOfCopies,
    this.mintingFeeNumber,
    this.mintingFeeToken,
    this.walletAddress,
    this.createAt,
    this.updateAt,
    this.royalties,
    this.fileType,
    this.txnHash,
    this.blockChainNetwork,
    this.nftTokenId,
    this.collectionAddress,
    this.evaluationId,
    this.isWhiteList,
    this.properties,
  );

  factory DetailHardNftResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailHardNftResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailHardNftResponseToJson(this);

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
  MarketType getTypeMarket(int type) {
    if (type == 2) {
      return MarketType.AUCTION;
    } else if (type == 3) {
      return MarketType.PAWN;
    } else if(type == 1){
      return MarketType.SALE;
    } else {
      return MarketType.NOT_ON_MARKET;
    }
  }

  NftMarket toOnSale() => NftMarket(
        evaluationId: evaluationId,
      );

  NFTOnAuction toAuction() => NFTOnAuction(
        evaluationId: evaluationId,
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
