import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';

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

class HaveWallet extends NftOnSaleSuccess {
  HaveWallet(NftMarket nftMarket) : super(nftMarket);

  @override
  List<Object?> get props => [nftMarket];
}

class NoWallet extends NftOnSaleSuccess {
  NoWallet(NftMarket nftMarket) : super(nftMarket);

  @override
  List<Object?> get props => [nftMarket];
}
