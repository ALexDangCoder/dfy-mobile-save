import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/nft_auction.dart';

mixin NFTRepository {
  Future<Result<NFTOnAuction>> getDetailNFTAuction(String marketId);
}
