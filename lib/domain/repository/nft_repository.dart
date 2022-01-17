import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/market_place/type_nft_model.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/domain/model/offer_nft.dart';

mixin NFTRepository {
  Future<Result<NFTOnAuction>> getDetailNFTAuction(String marketId);

  Future<Result<List<TypeNFTModel>>> getListTypeNFT();

  Future<Result<NftMarket>> getDetailNftOnSale(String marketId);

  Future<Result<NftOnPawn>> getDetailNftOnPawn(String pawnId);

  Future<Result<NftMarket>> getDetailHardNftOnSale(String nftId);

  Future<Result<NFTOnAuction>> getDetailHardNftOnAuction(String nftId);

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
  Future<Result<Evaluation>> getEvaluation(
      String evaluationId,
      );

  Future<Result<String>> buyNftRequest(
    BuyNftRequest nftRequest,
  );

  Future<Result<String>> bidNftRequest(
    BidNftRequest bidNftRequest,
  );

  Future<Result<List<OfferDetail>>> getOffer(
    String collateralId,
  );
}
