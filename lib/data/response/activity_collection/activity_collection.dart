import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_collection.g.dart';

@JsonSerializable()
class ActivityCollectionResponse extends Equatable {
  @JsonKey(name: 'rd')
  String? rd;

  @JsonKey(name: 'trace-id')
  String? traceId;

  @JsonKey(name: 'rc')
  int? rc;

  @JsonKey(name: 'total')
  int? total;

  @JsonKey(name: 'rows')
  List<ActivityCollection>? rows;

  ActivityCollectionResponse(
    this.rd,
    this.rc,
    this.total,
    this.rows,
    this.traceId,
  );

  factory ActivityCollectionResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityCollectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityCollectionResponseToJson(this);

  @override
  List<Object?> get props => [];
}

@JsonSerializable()
class ActivityCollection {
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'avatar_cid')
  String? avatarCid;
  @JsonKey(name: 'nft_name')
  String? nftName;
  @JsonKey(name: 'nft_owner')
  String? nftOwner;
  @JsonKey(name: 'event_date_time')
  int? eventDateTime;
  @JsonKey(name: 'from_address')
  String? fromAddress;
  @JsonKey(name: 'to_address')
  String? toAddress;
  @JsonKey(name: 'price_symbol')
  String? priceSymbol;
  @JsonKey(name: 'number_of_copies')
  int? numberOfCopies;
  @JsonKey(name: 'activity_type')
  int? activityType;
  @JsonKey(name: 'txn_hash')
  String? txnHash;
  @JsonKey(name: 'nft_standard')
  int? nftStandard;
  @JsonKey(name: 'market_status')
  int? marketStatus;
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'nft_id')
  String? nftId;
  @JsonKey(name: 'market_id')
  String? marketId;
  @JsonKey(name: 'nft_type')
  int? nftType;
  @JsonKey(name: 'cover_cid')
  String? coverCid;
  @JsonKey(name: 'file_type')
  String? fileType;
  @JsonKey(name: 'auction_type')
  int? auctionType;
  @JsonKey(name: 'pawn_id')
  String? pawnId;

  ActivityCollection(
    this.price,
    this.status,
    this.avatarCid,
    this.nftName,
    this.nftOwner,
    this.eventDateTime,
    this.fromAddress,
    this.toAddress,
    this.priceSymbol,
    this.numberOfCopies,
    this.activityType,
    this.txnHash,
    this.nftStandard,
    this.marketStatus,
    this.collectionAddress,
    this.nftId,
    this.marketId,
    this.nftType,
    this.coverCid,
    this.fileType,
    this.auctionType,
    this.pawnId,
  );

  factory ActivityCollection.fromJson(Map<String, dynamic> json) =>
      _$ActivityCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityCollectionToJson(this);

  ActivityCollectionModel toDomain() => ActivityCollectionModel(
        price,
        status,
        avatarCid,
        nftName,
        nftOwner,
        eventDateTime,
        fromAddress,
        toAddress,
        priceSymbol,
        numberOfCopies,
        activityType,
        txnHash,
        nftStandard,
        marketStatus,
        collectionAddress,
        nftId,
        marketId,
        nftType,
        coverCid,
        fileType,
        auctionType,
        pawnId,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
