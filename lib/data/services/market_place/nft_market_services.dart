import 'package:Dfy/data/response/nft_market/list_nft_my_acc_response.dart';
import 'package:Dfy/data/response/nft_market/list_response_from_api.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'nft_market_services.g.dart';

@RestApi()
abstract class NftMarketClient {
  factory NftMarketClient(Dio dio, {String baseUrl}) = _NftMarketClient;

  @GET(ApiConstants.GET_LIST_NFT)
  Future<ListNftResponseFromApi> getListNft(
    @Query('status') String? status,
    @Query('nft_type') String? nftType,
    @Query('name') String? name,
    @Query('collection_address') String? collectionId,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_LIST_NFT_MY_ACC)
  Future<ListNftMyAccResponseFromApi> getListNftMyAcc(
    @Query('status') String? status,
    @Query('nft_type') String? nftType,
    @Query('name') String? name,
    @Query('wallet_address') String? walletAddress,
    @Query('collection_id') String? collectionId,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @GET(ApiConstants.GET_HARD_LIST_NFT)
  Future<ListNftMyAccResponseFromApi> getListHardNft(
    @Query('status') String? status,
    @Query('name') String? name,
    @Query('page') String? page,
    @Query('size') String? size,
    @Query('limit') String? limit,
  );
}
