import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/model/nft_auction.dart';

mixin NFTRepository {
  Future<Result<NFTOnAuction>> getDetailNFTAuction(String marketId);
  Future<Result<List<TypeNFTModel>>> getListTypeNFT();
}
