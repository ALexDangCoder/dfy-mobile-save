import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_market_response.g.dart';

@JsonSerializable()
class NftMarketResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'file_cid')
  String avatarCid;
  @JsonKey(name: 'type')
  int type;
  @JsonKey(name: 'price')
  double price;
  @JsonKey(name: 'nft_id')
  String nftId;
  @JsonKey(name: 'market_type')
  int marketType;
  @JsonKey(name: 'start_time')
  int? startTime;
  @JsonKey(name: 'end_time')
  int? endTime;
  @JsonKey(name: 'token')
  String token;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopy;
  @JsonKey(name: 'total_copies')
  int? totalCopy;
  @JsonKey(name: 'file_type')
  String? fileType;

  NftMarketResponse(
    this.id,
    this.name,
    this.avatarCid,
    this.type,
    this.price,
    this.nftId,
    this.marketType,
    this.startTime,
    this.endTime,
    this.token,
    this.numberOfCopy,
    this.totalCopy,
    this.fileType,
  );

  factory NftMarketResponse.fromJson(Map<String, dynamic> json) =>
      _$NftMarketResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NftMarketResponseToJson(this);

  @override
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

  NftMarket toDomain() => NftMarket(
        marketId: id,
        marketType: getTypeMarket(marketType),
        typeImage: getTypeImage(fileType ?? ''),
        price: price,
        typeNFT: getTypeNft(type),
        image: getPath(avatarCid),
        nftId: nftId,
        tokenBuyOut: token,
        name: name,
        totalCopies: totalCopy,
        endTime: endTime,
        startTime: startTime,
        numberOfCopies: numberOfCopy,
      );
}
