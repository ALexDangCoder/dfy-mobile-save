import 'package:Dfy/data/response/nft/bidding_response.dart';
import 'package:Dfy/data/response/nft/hard_nft_respone.dart';
import 'package:Dfy/data/response/nft/history_response.dart';
import 'package:Dfy/data/response/nft/nft_on_auction_response.dart';
import 'package:Dfy/data/response/nft/nft_on_pawn_response.dart';
import 'package:Dfy/data/response/nft/nft_on_sale_response.dart';
import 'package:Dfy/data/response/nft/offer_nft_response.dart';
import 'package:Dfy/data/response/nft/owner_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/nft_service.dart';
import 'package:Dfy/domain/model/bidding_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:Dfy/domain/model/market_place/owner_nft.dart';
import 'package:Dfy/domain/model/nft_auction.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/model/nft_on_pawn.dart';
import 'package:Dfy/domain/model/offer_nft.dart';
import 'package:Dfy/domain/repository/nft_repository.dart';

class NFTRepositoryImpl implements NFTRepository {
  final NFTClient _nftClient;

  NFTRepositoryImpl(
    this._nftClient,
  );

  @override
  Future<Result<NFTOnAuction>> getDetailNFTAuction(String marketId) {
    return runCatchingAsync<AuctionResponse, NFTOnAuction>(
      () => _nftClient.getDetailNFTAuction(marketId),
      (response) => response.item!.toAuction(),
    );
  }

  @override
  Future<Result<NftMarket>> getDetailNftOnSale(String marketId) {
    return runCatchingAsync<OnSaleResponse, NftMarket>(
      () => _nftClient.getDetailNftOnSale(marketId),
      (response) => response.item!.toOnSale(),
    );
  }

  @override
  Future<Result<List<HistoryNFT>>> getHistory(
      String collectionAddress, String nftTokenId,) {
    return runCatchingAsync<HistoryResponse, List<HistoryNFT>>(
      () => _nftClient.getHistory(collectionAddress, nftTokenId),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<OwnerNft>>> getOwner(
      String collectionAddress, String nftTokenId,) {
    return runCatchingAsync<OwnerResponse, List<OwnerNft>>(
      () => _nftClient.getOwner(collectionAddress, nftTokenId),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<List<BiddingNft>>> getBidding(String auctionId) {
    return runCatchingAsync<BiddingResponse, List<BiddingNft>>(
      () => _nftClient.getBidding(auctionId),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<NftMarket>> getDetailHardNftOnSale(String nftId) {
    return runCatchingAsync<HardNftResponse, NftMarket>(
      () => _nftClient.getDetailHardNft(nftId),
      (response) => response.item?.toOnSale() ?? NftMarket.init(),
    );
  }

  @override
  Future<Result<NFTOnAuction>> getDetailHardNftOnAuction(String nftId) {
    return runCatchingAsync<HardNftResponse, NFTOnAuction>(
      () => _nftClient.getDetailHardNft(nftId),
      (response) => response.item?.toAuction() ?? NFTOnAuction.init(),
    );
  }

  @override
  Future<Result<NftOnPawn>> getDetailNftOnPawn(String pawnId) {
    return runCatchingAsync<OnPawnResponse, NftOnPawn>(
      () => _nftClient.getDetailNftOnPawn(pawnId),
      (response) => response.data!.toOnPawn(),
    );
  }

  @override
  Future<Result<List<OfferDetail>>> getOffer(String collateralId) {
    return runCatchingAsync<OfferResponse, List<OfferDetail>>(
          () => _nftClient.getOffer(collateralId),
          (response) => response.item?.toDomain() ?? [],
    );
  }
}
