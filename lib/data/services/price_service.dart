import 'package:Dfy/data/response/token/list_price_token_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'price_service.g.dart';
@RestApi()
abstract class PriceClient {
  @factoryMethod
  factory PriceClient(Dio dio, {String baseUrl}) = _PriceClient;

  @GET(ApiConstants.GET_PRICE_TOKEN_BY_SYMBOL)
  Future<ListPriceTokenResponse> getListPriceToken(
    @Query('symbols') String symbols,
  );
}
