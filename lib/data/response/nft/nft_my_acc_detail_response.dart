import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nft_my_acc_detail_response.g.dart';

@JsonSerializable()
class NftMyAccResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'item')
  DetailNftMyAccResponse? item;

  NftMyAccResponse(this.rc, this.rd, this.item);

  factory NftMyAccResponse.fromJson(Map<String, dynamic> json) =>
      _$NftMyAccResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NftMyAccResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class DetailNftMyAccResponse {
  @JsonKey(name: 'id')
  String? id;
  @JsonKey(name: 'txn_hash')
  String? txnHash;
  @JsonKey(name: 'total_of_copies')
  int? totalOfCopies;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'nft_id')
  String? nftId;
  @JsonKey(name: 'create_at')
  int? createAt;
  @JsonKey(name: 'update_at')
  int? updateAt;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;
  @JsonKey(name: 'nft_standard')
  int? nftStandard;
  @JsonKey(name: 'has_kyc')
  bool? hasKyc;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'market_status')
  int? marketStatus;
  @JsonKey(name: 'price')
  num? price;
  @JsonKey(name: 'price_symbol')
  String? priceSymbol;
  @JsonKey(name: 'time_duration_type')
  int? timeDurationType;
  @JsonKey(name: 'time_duration')
  int? timeDuration;
  @JsonKey(name: 'detail')
  String? detail;
  @JsonKey(name: 'be_id')
  int? beId;
  @JsonKey(name: 'nft_token_id')
  int? nftTokenId;
  @JsonKey(name: 'market_id')
  String? marketId;
  @JsonKey(name: 'type_nft')
  int? typeNft;
  @JsonKey(name: 'file_cid')
  String? fileCid;
  @JsonKey(name: 'evaluation_id')
  String? evaluationId;
  @JsonKey(name: 'is_white_list')
  bool? isWhiteList;
  @JsonKey(name: 'collection_name')
  String? collectionName;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'process_status')
  int? processStatus;

  DetailNftMyAccResponse(
    this.id,
    this.txnHash,
    this.totalOfCopies,
    this.name,
    this.nftId,
    this.createAt,
    this.updateAt,
    this.avatarCid,
    this.collectionAddress,
    this.walletAddress,
    this.nftStandard,
    this.hasKyc,
    this.numberOfCopies,
    this.marketStatus,
    this.price,
    this.priceSymbol,
    this.timeDurationType,
    this.timeDuration,
    this.detail,
    this.beId,
    this.nftTokenId,
    this.marketId,
    this.typeNft,
    this.fileCid,
    this.evaluationId,
    this.isWhiteList,
    this.collectionName,
    this.fileType,
    this.processStatus,
  );

  factory DetailNftMyAccResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailNftMyAccResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailNftMyAccResponseToJson(this);

  List<Object?> get props => [];

  String getPath(String avatarCid) {
    return ApiConstants.BASE_URL_IMAGE + avatarCid;
  }

  TypeImage getTypeImage(String type) {
    if (type.toLowerCase().contains('video')) {
      return TypeImage.VIDEO;
    } else {
      return TypeImage.IMAGE;
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

  NftMarket toNotOnMarket() => NftMarket(
        id: id,
        price: 0,
        marketId: marketId,
        processStatus: processStatus,
        name: name ?? '',
        description: detail,
        owner: walletAddress,
        typeNFT: getTypeNft(typeNft ?? 0),
        txnHash: txnHash,
        image: getPath(avatarCid ?? ''),
        symbolToken: priceSymbol,
        collectionName: collectionName,
        numberOfCopies: numberOfCopies,
        marketType: getTypeMarket(marketStatus ?? 0),
        createAt: createAt,
        updateAt: updateAt,
        collectionAddress: collectionAddress,
        nftTokenId: nftTokenId.toString(),
        nftStandard: (nftStandard == 0) ? '0' : '1',
        typeImage: getTypeImage(fileType ?? 'image'),
        isWhitelist: isWhiteList,
        evaluationId: evaluationId,
      );
}
