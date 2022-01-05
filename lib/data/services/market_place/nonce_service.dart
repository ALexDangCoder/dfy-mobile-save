import 'package:Dfy/data/response/market_place/market_place_res.dart';
import 'package:Dfy/data/response/nonce/nonce_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';

part 'nonce_service.g.dart';

@RestApi()
abstract class NonceClient {
  @factoryMethod
  factory NonceClient(Dio dio, {String baseUrl}) = _NonceClient;

  @GET(ApiConstants.GET_NONCE)
  Future<NonceResponse> getNonce(
    @Query('walletAddress') String walletAddress,
  );
}
