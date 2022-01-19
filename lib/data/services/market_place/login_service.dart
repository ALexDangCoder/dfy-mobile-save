import 'package:Dfy/data/response/market_place/login/login_response.dart';
import 'package:Dfy/data/response/market_place/nonce/nonce_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'login_service.g.dart';

@RestApi()
abstract class LoginClient {
  @factoryMethod
  factory LoginClient(Dio dio, {String baseUrl}) = _LoginClient;

  @POST(ApiConstants.LOGIN_MARKET)
  Future<LoginResponse> login(@Field('signature') String signature,
      @Field('walletAddress') String walletAddress);

  @GET(ApiConstants.GET_NONCE)
  Future<NonceResponse> getNonce(
    @Query('walletAddress') String walletAddress,
  );

  @GET(ApiConstants.GET_USER_PROFILE)
  Future<NonceResponse> getUserProfile();
}
