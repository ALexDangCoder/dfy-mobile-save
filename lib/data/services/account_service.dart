import 'package:Dfy/data/request/sign_in_request.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'account_service.g.dart';

@RestApi()
abstract class AccountClient {
  @factoryMethod
  factory AccountClient(Dio dio, {String baseUrl}) = _AccountClient;

}
