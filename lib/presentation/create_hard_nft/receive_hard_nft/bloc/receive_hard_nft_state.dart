import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:equatable/equatable.dart';

abstract class ReceiveHardNFTState extends Equatable{}

class ReceiveHardNFTLoading extends ReceiveHardNFTState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ReceiveHardNFTLoaded extends ReceiveHardNFTState {
  final DetailAssetHardNft data;
  final NftMarket? nftMarket;
  ReceiveHardNFTLoaded (this.data,{this.nftMarket});

  @override
  List<Object?> get props => [data];
}

class ReceiveHardNFTLoadFail extends ReceiveHardNFTState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}