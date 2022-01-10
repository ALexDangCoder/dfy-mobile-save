import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'owner_response.g.dart';

@JsonSerializable()
class OwnerResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'rows')
  List<DetailOwnerResponse>? item;

  OwnerResponse(this.rc, this.rd, this.item);

  factory OwnerResponse.fromJson(Map<String, dynamic> json) =>
      _$OwnerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OwnerResponseToJson(this);

  @override
  List<Object?> get props => [];

  List<OwnerNft>? toDomain() => item?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class DetailOwnerResponse {
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'be_id')
  String? beId;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'detail')
  String? detail;
  @JsonKey(name: 'has_kyc')
  bool? hasKyc;
  @JsonKey(name: 'market_id')
  String? marketId;
  @JsonKey(name: 'market_status')
  int? marketStatus;
  @JsonKey(name: 'nft_standard')
  int? nftStandard;
  @JsonKey(name: 'nft_token_id')
  String? nftTokenId;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'total_copies')
  int? totalCopies;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'price_symbol')
  String? priceSymbol;
  @JsonKey(name: 'time_duration')
  int? timeDuration;
  @JsonKey(name: 'time_duration_type')
  int? timeDurationType;
  @JsonKey(name: 'type')
  int? type;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;

  DetailOwnerResponse({
    this.avatarCid,
    this.beId,
    this.collectionAddress,
    this.detail,
    this.hasKyc,
    this.marketId,
    this.marketStatus,
    this.nftStandard,
    this.nftTokenId,
    this.numberOfCopies,
    this.totalCopies,
    this.price,
    this.priceSymbol,
    this.timeDuration,
    this.timeDurationType,
    this.type,
    this.walletAddress,
  });

  factory DetailOwnerResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailOwnerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailOwnerResponseToJson(this);

  List<Object?> get props => [];

  OwnerNft toDomain() => OwnerNft(
    avatarCid: avatarCid,
    beId: beId,
    collectionAddress: collectionAddress,
    detail: detail,
    hasKyc: hasKyc,
    marketId: marketId,
    marketStatus: marketStatus,
    nftStandard: nftStandard,
    nftTokenId: nftTokenId,
    numberOfCopies: numberOfCopies,
    price: price,
    priceSymbol: priceSymbol,
    timeDuration: timeDuration,
    timeDurationType: timeDurationType,
    totalCopies: totalCopies,
    type: type,
    walletAddress: walletAddress,
  );
}
