import 'package:Dfy/domain/model/market_place/explore_category_model.dart';
import 'package:Dfy/domain/model/market_place/nft_collection_explore_model.dart';
import 'package:Dfy/domain/model/market_place/nft_model_full.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_collection_explore_res.g.dart';

@JsonSerializable()
class NftCollectionExploreResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'position')
  int? position;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'item_id')
  String? itemId;
  @JsonKey(name: 'file_cid')
  String? fileCid;
  @JsonKey(name: 'nft_id')
  String? nftId;
  @JsonKey(name: 'market_type')
  int? marketType;
  @JsonKey(name: 'start_time')
  int? startTime;
  @JsonKey(name: 'end_time')
  int? endTime;
  @JsonKey(name: 'reserve_price')
  dynamic reservePrice;
  @JsonKey(name: 'buy_out_price')
  double? buyOutPrice;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'total_copies')
  int? totalCopies;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'is_reserve_price')
  dynamic isReservePrice;

  //Explore categories
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'banner_cid')
  String? bannerCid;
  @JsonKey(name: 'display_column')
  int? displayCol;
  @JsonKey(name: 'display_row')
  int? displayRow;

  //outstading collection
  @JsonKey(name: 'feature_cid')
  String? featureCid;
  @JsonKey(name: 'total_nft')
  int? totalNft;
  @JsonKey(name: 'nft_owner_count')
  int? nftOwnerCount;

  NftCollectionExploreResponse(
    this.id,
    this.position,
    this.type,
    this.price,
    this.name,
    this.itemId,
    this.fileCid,
    this.nftId,
    this.marketType,
    this.startTime,
    this.endTime,
    this.reservePrice,
    this.buyOutPrice,
    this.token,
    this.numberOfCopies,
    this.totalCopies,
    this.fileType,
    this.coverCid,
    this.isReservePrice,
    this.avatarCid,
    this.bannerCid,
    this.displayCol,
    this.displayRow,
    this.featureCid,
    this.totalNft,
    this.nftOwnerCount,
  );

  factory NftCollectionExploreResponse.fromJson(Map<String, dynamic> json) =>
      _$NftCollectionExploreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NftCollectionExploreResponseToJson(this);

  @override
  List<Object?> get props => [];

  NftCollectionExploreModel toDomain() =>
      NftCollectionExploreModel(
        id: id,
        type: type,
        token: token,
        totalCopies: totalCopies,
        totalNft: totalNft,
        endTime: endTime,
        fileType: fileType,
        name: name,
        avatarCid: avatarCid,
        displayCol: displayCol,
        displayRow: displayRow,
        bannerCid: bannerCid,
        reservePrice: reservePrice,
        position: position,
        fileCid: fileCid,
        buyOutPrice: buyOutPrice,
        startTime: startTime,
        featureCid: featureCid,
        isReservePrice: isReservePrice,
        marketType: marketType,
        numberOfCopies: numberOfCopies,
        coverCid: coverCid,
        price: price,
        itemId: itemId,
        nftId: nftId,
        nftOwnerCount: nftOwnerCount,
      );

}
