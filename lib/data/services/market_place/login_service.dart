import 'package:Dfy/data/response/market_place/login/login_response.dart';
import 'package:Dfy/data/response/market_place/login/nonce_response.dart';
import 'package:Dfy/data/response/market_place/login/otp_response.dart';
import 'package:Dfy/data/response/market_place/login/user_profile.dart';
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
  Future<ProfileResponse> getUserProfile();

  @POST(ApiConstants.REFRESH_TOKEN)
  Future<LoginResponse> refreshToken(
    @Field('refresh_token') String refreshToken,
  );

  @POST(ApiConstants.GET_OTP)
  Future<OTPResponse> getOTP(
    @Field('email') String email,
    @Field('type') int type,
  );

  @PUT(ApiConstants.VERIFY_OTP)
  Future<LoginResponse> verifyOTP(
    @Field('otp') String otp,
    @Field('transaction_id') String transactionId,
  );

  @PUT(ApiConstants.LOG_OUT)
  Future<void> logout();
}
