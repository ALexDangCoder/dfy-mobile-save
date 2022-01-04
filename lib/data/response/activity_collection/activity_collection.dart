import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_collection.g.dart';

@JsonSerializable()
class ActivityCollection extends Equatable {
  @JsonKey(name: 'processing')
  bool processing;
  @JsonKey(name: 'price')
  double price;
  @JsonKey(name: 'quantity')
  int quantity;
  @JsonKey(name: 'token')
  String token;
  @JsonKey(name: 'nft_standard')
  int nftStandard;
  @JsonKey(name: 'history_type')
  int historyType;
  @JsonKey(name: 'collection_address')
  String collectionAddress;
  @JsonKey(name: 'wallet_address')
  String walletAddress;
  @JsonKey(name: 'from_address')
  String fromAddress;
  @JsonKey(name: 'to_address')
  String toAddress;
  @JsonKey(name: 'event_date_time')
  int eventDateTime;
  @JsonKey(name: 'excepted_loan')
  double exceptedLoan;
  @JsonKey(name: 'txn_hash')
  String txnHash;
  @JsonKey(name: 'price_symbol')
  String priceSymbol;
  @JsonKey(name: 'nft_token_id')
  int nftTokenId;
  @JsonKey(name: 'market_id')
  String marketId;
  @JsonKey(name: 'event_name')
  String eventName;
  @JsonKey(name: 'event_type')
  int eventType;
  @JsonKey(name: 'id_ref')
  int idRef;
  @JsonKey(name: 'is_you')
  bool isYou;


  ActivityCollection(
      this.processing,
      this.price,
      this.quantity,
      this.token,
      this.nftStandard,
      this.historyType,
      this.collectionAddress,
      this.walletAddress,
      this.fromAddress,
      this.toAddress,
      this.eventDateTime,
      this.exceptedLoan,
      this.txnHash,
      this.priceSymbol,
      this.nftTokenId,
      this.marketId,
      this.eventName,
      this.eventType,
      this.idRef,
      this.isYou);

  factory ActivityCollection.fromJson(Map<String, dynamic> json) =>
      _$ActivityCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityCollectionToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
