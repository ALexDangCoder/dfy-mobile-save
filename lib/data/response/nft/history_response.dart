import 'package:Dfy/domain/model/history_nft.dart';
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
  @JsonKey(name: 'collectionAddress')
  String? collectionAddress;
  @JsonKey(name: 'eventDateTime')
  int? eventDateTime;
  @JsonKey(name: 'eventName')
  String? eventName;
  @JsonKey(name: 'eventType')
  int? eventType;
  @JsonKey(name: 'exceptedLoan')
  num? exceptedLoan;
  @JsonKey(name: 'fromAddress')
  String? fromAddress;
  @JsonKey(name: 'historyType')
  int? historyType;
  @JsonKey(name: 'idRef')
  String? idRef;
  @JsonKey(name: 'isYou')
  bool? isYou;
  @JsonKey(name: 'marketId')
  String? marketId;
  @JsonKey(name: 'nftStandard')
  int? nftStandard;
  @JsonKey(name: 'nftTokenId')
  int? nftTokenId;
  @JsonKey(name: 'price')
  num? price;
  @JsonKey(name: 'priceSymbol')
  String? priceSymbol;
  @JsonKey(name: 'processing')
  bool? processing;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'toAddress')
  String? toAddress;
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'txnHash')
  String? txnHash;
  @JsonKey(name: 'walletAddress')
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
