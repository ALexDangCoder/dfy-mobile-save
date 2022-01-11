import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';

mixin NFTRepository {
  Future<Result<NFTOnAuction>> getDetailNFTAuction(String marketId);

  Future<Result<NftMarket>> getDetailNftOnSale(String marketId);

  Future<Result<List<HistoryNFT>>> getHistory(
    String collectionAddress,
    String nftTokenId,
  );

  Future<Result<List<OwnerNft>>> getOwner(
    String collectionAddress,
    String nftTokenId,
  );

  Future<Result<List<BiddingNft>>> getBidding(
    String auctionId,
  );

  Future<Result<String>> buyNftRequest(
    BuyNftRequest nftRequest,
  );
}
