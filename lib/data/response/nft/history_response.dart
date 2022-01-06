import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'history_response.g.dart';

@JsonSerializable()
class HistoryResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'rows')
  List<DetailHistoryResponse>? item;

  HistoryResponse(this.rc, this.rd, this.item);

  factory HistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryResponseToJson(this);

  @override
  List<Object?> get props => [];
  List<HistoryNFT>? toDomain() => item?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class DetailHistoryResponse {
  @JsonKey(name: 'collection_address')
  String? collectionAddress;
  @JsonKey(name: 'event_date_time')
  int? eventDateTime;
  @JsonKey(name: 'event_name')
  String? eventName;
  @JsonKey(name: 'event_type')
  int? eventType;
  @JsonKey(name: 'excepted_loan')
  num? exceptedLoan;
  @JsonKey(name: 'from_address')
  String? fromAddress;
  @JsonKey(name: 'history_type')
  int? historyType;
  @JsonKey(name: 'id_ref')
  String? idRef;
  @JsonKey(name: 'is_you')
  bool? isYou;
  @JsonKey(name: 'market_id')
  String? marketId;
  @JsonKey(name: 'nft_standard')
  int? nftStandard;
  @JsonKey(name: 'nft_token_id')
  int? nftTokenId;
  @JsonKey(name: 'price')
  num? price;
  @JsonKey(name: 'price_symbol')
  String? priceSymbol;
  @JsonKey(name: 'processing')
  bool? processing;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'to_address')
  String? toAddress;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'txn_hash')
  String? txnHash;
  @JsonKey(name: 'wallet_address')
  String? walletAddress;


  DetailHistoryResponse(
      this.collectionAddress,
      this.eventDateTime,
      this.eventName,
      this.eventType,
      this.exceptedLoan,
      this.fromAddress,
      this.historyType,
      this.idRef,
      this.isYou,
      this.marketId,
      this.nftStandard,
      this.nftTokenId,
      this.price,
      this.priceSymbol,
      this.processing,
      this.quantity,
      this.toAddress,
      this.token,
      this.txnHash,
      this.walletAddress,
      );

  factory DetailHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailHistoryResponseToJson(this);

  List<Object?> get props => [];
  HistoryNFT toDomain() => HistoryNFT(
    eventDateTime: eventDateTime,
    eventName: eventName,
    eventType: eventType,
    exceptedLoan: exceptedLoan,
    fromAddress: fromAddress,
    historyType: historyType,
    idRef: idRef,
    isYou: isYou,
    marketId: marketId,
    nftStandard: nftStandard,
    nftTokenId: nftTokenId,
    price: price,
    priceSymbol: priceSymbol,
    processing: processing,
    quantity: quantity,
    toAddress: toAddress,
    token: token,
    txnHash: txnHash,
    walletAddress: walletAddress,

  );

}
