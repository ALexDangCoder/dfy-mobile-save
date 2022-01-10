import 'package:Dfy/data/response/collection/collection_res.dart';
import 'package:Dfy/data/response/market_place/market_place_res.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'marketplace_client.g.dart';

@RestApi()
abstract class MarketPlaceHomeClient {
  @factoryMethod
  factory MarketPlaceHomeClient(Dio dio, {String baseUrl}) =
      _MarketPlaceHomeClient;

  @GET(ApiConstants.GET_LIST_NFT_COLLECTION_EXPLORE)
  Future<MarketPlaceResponse> getListNftCollectionExplore();

  @GET(ApiConstants.GET_LIST_COLLECTION)
  Future<ListCollectionResponse> getListCollection(
      @Query('address') String? address,
      @Query('name') String? name,
      @Query('sort') int? sort);
}
