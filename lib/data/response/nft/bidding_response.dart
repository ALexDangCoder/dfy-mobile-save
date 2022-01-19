import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bidding_response.g.dart';

@JsonSerializable()
class BiddingResponse extends Equatable {
  @JsonKey(name: 'rc')
  int? rc;
  @JsonKey(name: 'rd')
  String? rd;
  @JsonKey(name: 'rows')
  List<DetailBiddingResponse>? item;

  BiddingResponse(this.rc, this.rd, this.item);

  factory BiddingResponse.fromJson(Map<String, dynamic> json) =>
      _$BiddingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BiddingResponseToJson(this);

  @override
  List<Object?> get props => [];

  List<BiddingNft>? toDomain() => item?.map((e) => e.toDomain()).toList();
}

@JsonSerializable()
class DetailBiddingResponse {
  @JsonKey(name: 'auction_id')
  String? auctionId;
  @JsonKey(name: 'bid_value')
  double? bidValue;
  @JsonKey(name: 'bidding_account')
  String? biddingAccount;
  @JsonKey(name: 'bidding_wallet')
  String? biddingWallet;
  @JsonKey(name: 'nft_ref_id')
  String? nftRefId;
  @JsonKey(name: 'status')
  int? status;
  @JsonKey(name: 'time')
  int? time;
  @JsonKey(name: 'txn_hash')
  String? txnHash;

  DetailBiddingResponse(
    this.auctionId,
    this.bidValue,
    this.biddingAccount,
    this.biddingWallet,
    this.nftRefId,
    this.status,
    this.time,
    this.txnHash,
  );

  factory DetailBiddingResponse.fromJson(Map<String, dynamic> json) =>
      _$DetailBiddingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailBiddingResponseToJson(this);

  List<Object?> get props => [];

  BiddingNft toDomain() => BiddingNft(
        auctionId: auctionId,
        bidValue: bidValue,
        biddingAccount: biddingAccount,
        biddingWallet: biddingWallet,
        nftRefId: nftRefId,
        status: status,
        time: time,
        txnHash: txnHash,
      );
}
