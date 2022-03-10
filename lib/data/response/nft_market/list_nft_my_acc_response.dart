import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_nft_my_acc_response.g.dart';

@JsonSerializable()
class ListNftMyAccResponseFromApi extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'total')
  int? total;
  @JsonKey(name: 'rows')
  List<NftMyAccResponse>? rows;

  ListNftMyAccResponseFromApi(this.rc, this.rd, this.total, this.rows);

  factory ListNftMyAccResponseFromApi.fromJson(Map<String, dynamic> json) =>
      _$ListNftMyAccResponseFromApiFromJson(json);

  Map<String, dynamic> toJson() => _$ListNftMyAccResponseFromApiToJson(this);

  @override
  List<Object?> get props => [];

  List<NftMarket>? toDomain() => rows?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class NftMyAccResponse extends Equatable {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'market_id')
  String? marketId;
  @JsonKey(name: 'pawn_id')
  String? pawnId;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'file_cid')
  String? fileCid;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'standard')
  int? standard;
  @JsonKey(name: 'process_status')
  int? processStatus;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'total_of_copies')
  int? totalOfCopies;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'market_status')
  int? marketStatus;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'nft_token_id')
  String? nftTokenId;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'price_symbol')
  String? priceSymbol;

  NftMyAccResponse(
    this.id,
    this.marketId,
    this.pawnId,
    this.name,
    this.fileCid,
    this.type,
    this.standard,
    this.processStatus,
    this.numberOfCopies,
    this.totalOfCopies,
    this.fileType,
    this.marketStatus,
    this.collectionAddress,
    this.walletAddress,
    this.nftTokenId,
    this.price,
    this.priceSymbol,
      this.coverCid,
  );

  factory NftMyAccResponse.fromJson(Map<String, dynamic> json) =>
      _$NftMyAccResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NftMyAccResponseToJson(this);

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
    } else if (type == 1) {
      return MarketType.SALE;
    } else {
      return MarketType.NOT_ON_MARKET;
    }
  }

  int returnPawnId(String pawnId) {
    if (pawnId == '') {
      return 0;
    } else {
      return int.parse(pawnId);
    }
  }

  NftMarket toDomain() => NftMarket(
        marketId: marketId,
        marketType: getTypeMarket(marketStatus ?? 0),
        marketStatus: marketStatus,
        typeImage: getTypeImage(fileType ?? 'image'),
        cover: getPath(coverCid ?? ''),
        typeNFT: getTypeNft(type ?? 0),
        image: getPath(fileCid ?? ''),
        nftId: id,
        nftTokenId: nftTokenId,
        price: price,
        name: name,
        tokenBuyOut: priceSymbol,
        pawnId: returnPawnId(pawnId ?? ''),
        totalCopies: totalOfCopies,
        numberOfCopies: numberOfCopies,
        walletAddress: walletAddress,
        processStatus: processStatus,
        nftStandard: (standard == 0) ? ERC_721 : ERC_1155,
        collectionAddress: collectionAddress,
      );
}
