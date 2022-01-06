import 'package:Dfy/data/response/nonce/nonce_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

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
