import 'package:Dfy/data/request/bid_nft_request.dart';
import 'package:Dfy/data/request/buy_nft_request.dart';
import 'package:Dfy/data/request/buy_out_request.dart';
import 'package:Dfy/data/request/send_offer_request.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluators_response.dart';
import 'package:Dfy/data/response/market_place/confirm_res.dart';
import 'package:Dfy/data/response/market_place/list_type_nft_res.dart';
import 'package:Dfy/data/response/nft/bidding_response.dart';
import 'package:Dfy/data/response/nft/data_detail_offer_response.dart';
import 'package:Dfy/data/response/nft/evaluation_response.dart';
import 'package:Dfy/data/response/nft/hard_nft_respone.dart';
import 'package:Dfy/data/response/nft/history_response.dart';
import 'package:Dfy/data/response/nft/nft_my_acc_detail_response.dart';
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

  @GET('${ApiConstants.GET_EVALUATION_HARD_NFT}{evaluationId}')
  Future<EvaluationResponse> getEvaluation(
    @Path('evaluationId') String evaluationId,
  );
  @GET('${ApiConstants.GET_EVALUATOR_HARD_NFT}{evaluationId}')
  Future<EvaluatorsDetailResponse> getEvaluator(
      @Path('evaluationId') String evaluationId,
      );

  @GET(ApiConstants.GET_LIST_TYPE_NFT)
  Future<ListTypeNFTResponse> getListTypeNFT();

  @GET('${ApiConstants.GET_DETAIL_NFT_ON_SALE}{marketId}')
  Future<OnSaleResponse> getDetailNftOnSale(
    @Path('marketId') String marketID,
  );

  @GET('${ApiConstants.GET_DETAIL_NFT_NOT_ON_MARKET}{nftId}')
  Future<NftMyAccResponse> getDetailNftNotOnMarket(
    @Path('nftId') String nftId,
    @Query('type') String type,
  );

  @GET(ApiConstants.GET_DETAIL_NFT_NOT_ON_MARKET)
  Future<HardNftResponse> getDetailNft(
    @Query('collection-address') String collectionAddress,
    @Query('nft-token-id') String nftTokenId,
  );
  @GET('${ApiConstants.GET_DETAIL_NFT_NOT_ON_MARKET_2}{nftId}')
  Future<HardNftResponse> getDetailNft2(
      @Path('nftId') String nftId,
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

  @POST(ApiConstants.BUY_NFT)
  Future<String> buyNftRequest(
    @Body() BuyNftRequest buyNftRequest,
  );

  @POST(ApiConstants.BID_NFT)
  Future<String> bidNftRequest(
    @Body() BidNftRequest bidNftRequest,
  );

  @POST(ApiConstants.BUY_OUT)
  Future<String> buyOutRequest(
    @Body() BuyOutRequest buyOutRequest,
  );

  @GET('${ApiConstants.OFFER_DETAIL}{id}')
  Future<DataOfferDetailResponse> getOfferDetail(
    @Path('id') int id,
  );

  //cancel sale
  @POST(ApiConstants.CANCEL_SALE)
  Future<ConfirmResponse> cancelSale(
    @Field('market_id') String marketId,
    @Field('txn_hash') String txnHash,
  );

  //Confirm cancel  auction:
  @POST(ApiConstants.CANCEL_AUCTION)
  Future<ConfirmResponse> cancelAuction(
    @Field('auction_id') String marketId,
    @Field('txn_hash') String txnHash,
  );

  //Accept offer
  @PUT(ApiConstants.ACCEPT_OFFER)
  Future<String> acceptOffer(
    @Path('id') int idOffer,
  );

  //reject offer:
  @PUT(ApiConstants.REJECT_OFFER)
  Future<String> rejectOffer(
    @Path('walletAddress') String walletAddress,
    @Path('collateralId') int collateralId,
    @Path('id') int idOffer,
  );

  //send offer
  @POST(ApiConstants.SEND_OFFER)
  Future<String> sendOffer(
    @Body() SendOfferRequest request,
  );

  //Confirm cancel  pawn:
  @POST('${ApiConstants.CANCEL_PAWN}{id}')
  Future<ConfirmResponse> cancelPawn(
    @Path('id') int pawnId,
  );
}
