import 'package:Dfy/data/response/login/login_response.dart';
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
}
