import 'package:Dfy/data/response/search_market/search_market_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'search_market_client.g.dart';

@RestApi()
abstract class SearchMarketClient {
  @factoryMethod
  factory SearchMarketClient(Dio dio, {String baseUrl}) = _SearchMarketClient;

  @GET(ApiConstants.GET_LIST_NFT_COLLECTION_EXPLORE_SEARCH)
  Future<SearchMarketResponse> getCollectionFeatNftSearch(
    @Query('name') String? name,
  );
}
