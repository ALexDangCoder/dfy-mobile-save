import 'package:Dfy/data/response/market_place/list_type_nft_res.dart';
import 'package:Dfy/data/response/nft/bidding_response.dart';
import 'package:Dfy/data/response/nft/hard_nft_respone.dart';
import 'package:Dfy/data/response/nft/history_response.dart';
import 'package:Dfy/data/response/nft/nft_on_auction_response.dart';
import 'package:Dfy/data/response/nft/nft_on_pawn_response.dart';
import 'package:Dfy/data/response/nft/nft_on_sale_response.dart';
import 'package:Dfy/data/response/nft/offer_nft_response.dart';
import 'package:Dfy/data/response/nft/owner_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'nft_service.g.dart';

@RestApi()
abstract class NFTClient {
  @factoryMethod
  factory NFTClient(Dio dio, {String baseUrl}) = _NFTClient;

  @GET('${ApiConstants.GET_DETAIL_NFT_AUCTION}{marketId}')
  Future<AuctionResponse> getDetailNFTAuction(
    @Path('marketId') String marketID,
  );
  @GET(ApiConstants.GET_LIST_TYPE_NFT)
  Future<ListTypeNFTResponse> getListTypeNFT();

  @GET('${ApiConstants.GET_DETAIL_NFT_ON_SALE}{marketId}')
  Future<OnSaleResponse> getDetailNftOnSale(
      @Path('marketId') String marketID,
      );
  @GET('${ApiConstants.GET_DETAIL_NFT_ON_PAWN}{id}')
  Future<OnPawnResponse> getDetailNftOnPawn(
      @Path('id') String id,
      );

  @GET('${ApiConstants.GET_DETAIL_HARD_NFT}{nft_id}')
  Future<HardNftResponse> getDetailHardNft(
      @Path('nft_id') String nftId,
      );
  @GET(ApiConstants.GET_HISTORY)
  Future<HistoryResponse> getHistory(
      @Query('collection_address') String collectionAddress,
      @Query('nft_token_id') String nftTokenId,
      );

  @GET(ApiConstants.GET_OWNER)
  Future<OwnerResponse> getOwner(
      @Query('collection_address') String collectionAddress,
      @Query('nft_token_id') String nftTokenId,
      );
  @GET(ApiConstants.GET_BIDDING)
  Future<BiddingResponse> getBidding(
      @Query('auction_id') String auctionId,
      );

  @GET(ApiConstants.GET_OFFER)
  Future<OfferResponse> getOffer(
      @Query('collateralId') String collateralId,
      );
}
