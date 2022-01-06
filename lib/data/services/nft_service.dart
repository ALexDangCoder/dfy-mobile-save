import 'package:Dfy/data/response/nft/nft_on_auction_response.dart';
import 'package:Dfy/data/response/nft/nft_on_sale_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'nft_service.g.dart';

@RestApi()
abstract class NFTClient {
  @factoryMethod
  factory NFTClient(Dio dio, {String baseUrl}) = _NFTClient;

  @GET(ApiConstants.GET_DETAIL_NFT_AUCTION)
  Future<AuctionResponse> getDetailNFTAuction(
    @Path('marketId') String marketID,
  );

  @GET('${ApiConstants.GET_DETAIL_NFT_ON_SALE}{marketId}')
  Future<OnSaleResponse> getDetailNftOnSale(
      @Path('marketId') String marketID,
      );

}
