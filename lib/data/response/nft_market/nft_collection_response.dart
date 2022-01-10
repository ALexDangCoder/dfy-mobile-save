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
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'standard')
  String? standard;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'id_ref')
  String? idRef;
  @JsonKey(name: 'market_id')
  int? marketId;
  @JsonKey(name: 'market_type')
  String? marketType;
  @JsonKey(name: 'file_cid')
  String? fileCid;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'total_of_copies')
  int? totalOfCopies;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'market_status')
  int? marketStatus;
  @JsonKey(name: 'expected_loan_amount')
  double? expectedLoanAmount;
  @JsonKey(name: 'expected_loan_symbol')
  String? expectedLoanSymbol;

  NftCollectionResponse(
    this.type,
    this.token,
    this.standard,
    this.name,
    this.idRef,
    this.marketId,
    this.marketType,
    this.fileCid,
    this.coverCid,
    this.numberOfCopies,
    this.totalOfCopies,
    this.fileType,
    this.marketStatus,
    this.expectedLoanAmount,
    this.expectedLoanSymbol,
  );

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
    } else if (type == 1) {
      return MarketType.SALE;
    } else {
      return MarketType.NOT_ON_MARKET;
    }
  }

  NftMarket toDomain() => NftMarket(
        marketId: 'ádf' ?? '',
        marketType: getTypeMarket(0 ?? 0),
        typeImage: getTypeImage(fileType ?? ''),
        price: 0 ?? 0,
        typeNFT: getTypeNft(type ?? 0),
        image: getPath('file_cid' ?? ''),
        tokenBuyOut: token,
        name: name ?? '',
        totalCopies: 0,
        endTime: 0,
        startTime: 0,
        numberOfCopies: 0,
      );
}
