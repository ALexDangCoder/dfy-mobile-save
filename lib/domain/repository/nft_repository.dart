import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';

mixin NFTRepository {
  Future<Result<NFTOnAuction>> getDetailNFTAuction(String marketId);
  Future<Result<NftMarket>> getDetailNftOnSale(String marketId);
}
