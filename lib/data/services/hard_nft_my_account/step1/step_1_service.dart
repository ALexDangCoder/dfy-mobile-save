import 'package:Dfy/data/response/create_hard_nft/evaluators_response.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/country_res.dart';
import 'package:Dfy/data/response/hard_nft_my_account/step1/phone_code_res.dart';

import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'step_1_service.g.dart';

@RestApi()
abstract class Step1Client {
  @factoryMethod
  factory Step1Client(Dio dio, {String baseUrl}) = _Step1Client;

  @GET(ApiConstants.GET_PHONE_CODE)
  Future<ListPhoneCodeResponse> getPhoneCode();

  @GET(ApiConstants.GET_COUNTRIES)
  Future<ListCountryResponse> getCountries();
}
