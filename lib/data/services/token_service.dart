import 'package:Dfy/data/response/token/list_price_token_response.dart';
import 'package:Dfy/data/response/token/list_token_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'token_service.g.dart';

@RestApi()
abstract class TokenClient {
  @factoryMethod
  factory TokenClient(Dio dio, {String baseUrl}) = _TokenClient;

  @GET(ApiConstants.GET_LIST_TOKEN)
  Future<ListTokenResponse> getListToken();

  @GET(ApiConstants.GET_PRICE_TOKEN_BY_SYMBOL)
  Future<ListPriceTokenResponse> getListPriceToken(
    @Query('symbols') String symbols,
  );
}
