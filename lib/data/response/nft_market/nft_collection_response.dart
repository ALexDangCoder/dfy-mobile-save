import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_collection_response.g.dart';

@JsonSerializable()
class NftCollectionResponse extends Equatable {
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'standard')
  String? standard;
  @JsonKey(name: 'market_id')
  String? market_id;
  @JsonKey(name: 'id_ref')
  String? id_ref;
  @JsonKey(name: 'market_type')
  String? market_type;
  @JsonKey(name: 'file_cid')
  String? file_cid;
  @JsonKey(name: 'number_of_copies')
  int? number_of_copies;
  @JsonKey(name: 'total_of_copies')
  int? total_of_copies;
  @JsonKey(name: 'market_status')
  int? market_status;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'cover_cid')
  String? cover_cid;
  @JsonKey(name: 'is_reserve_price')
  bool? is_reserve_price;
  @JsonKey(name: 'start_time')
  int? start_time;
  @JsonKey(name: 'end_time')
  int? end_time;


  NftCollectionResponse(
      this.type,
      this.name,
      this.price,
      this.token,
      this.standard,
      this.market_id,
      this.id_ref,
      this.market_type,
      this.file_cid,
      this.number_of_copies,
      this.total_of_copies,
      this.market_status,
      this.fileType,
      this.cover_cid,
      this.is_reserve_price,
      this.start_time,
      this.end_time);

  factory NftCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$NftCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NftCollectionResponseToJson(this);

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
    } else if(type ==1){
      return MarketType.SALE;
    }else{
      return MarketType.NOT_ON_MARKET;
    }
  }


  NftMarket toDomain() => NftMarket(
        marketId: market_id ?? '',
        marketType: getTypeMarket(market_status ?? 0),
        typeImage: getTypeImage(fileType ?? ''),
        price: price ?? 0,
        typeNFT: getTypeNft(type ?? 0),
        image: getPath(file_cid ?? ''),
        tokenBuyOut: token,
        name: name ?? '',
        totalCopies: total_of_copies,
        endTime: end_time,
        startTime: start_time,
        numberOfCopies: number_of_copies,
      );
}
