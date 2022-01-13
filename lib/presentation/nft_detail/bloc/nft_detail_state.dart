import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/web3/abi/nft.g.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';

abstract class NFTDetailState extends BaseState {}

class NFTDetailInitial extends NFTDetailState {
  @override
  List<Object?> get props => [];
}

class NftOnSaleSuccess extends NFTDetailState {
  final NftMarket nftMarket;

  NftOnSaleSuccess(this.nftMarket);

  @override
  List<Object?> get props => [nftMarket];
}

class NftOnSaleFail extends NFTDetailState {
  @override
  List<Object?> get props => [];
}

class Web3Fail extends NFTDetailState {
  @override
  List<Object?> get props => [];
}

class NftOnPawnSuccess extends NFTDetailState {
  final NftOnPawn nftOnPawn;

  NftOnPawnSuccess(this.nftOnPawn);

  @override
  List<Object?> get props => [];
}


class HaveWallet extends NftOnSaleSuccess {
  HaveWallet(NftMarket nftMarket) : super(nftMarket);

  @override
  List<Object?> get props => [nftMarket];
}

class NftOnAuctionSuccess extends NFTDetailState {
  final NFTOnAuction nftOnAuction;

  NftOnAuctionSuccess(this.nftOnAuction);

  @override
  List<Object?> get props => [];
}

class NoWallet extends NftOnSaleSuccess {
  NoWallet(NftMarket nftMarket) : super(nftMarket);

  @override
  List<Object?> get props => [nftMarket];
}

class GetGasLimitSuccess extends NftOnSaleSuccess {
  final String gasLimit;

  GetGasLimitSuccess(NftMarket nftMarket, this.gasLimit) : super(nftMarket);

  @override
  List<Object?> get props => [gasLimit];
}
