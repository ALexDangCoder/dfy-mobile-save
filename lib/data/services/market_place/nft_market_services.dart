import 'package:Dfy/data/response/nft_market/list_nft_collection_respone.dart';
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
    @Query('collection_id') String? collectionId,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @POST(ApiConstants.GET_LIST_NFT_COLLECTION)
  Future<ListNftCollectionResponse> getListNftCollection(
      @Field('collection_id') String? collectionId,
      @Field('page') int? page,
      @Field('size') int? size,
      @Field('name_nft') String? nameNft,
      @Field('market_type') List<int>? listMarketType);
}
