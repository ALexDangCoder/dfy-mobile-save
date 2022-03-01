import 'package:Dfy/data/response/pawn/pawn_list/pawn_list_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'pawn_service.g.dart';

@RestApi()
abstract class PawnService {
  @factoryMethod
  factory PawnService(Dio dio, {String baseUrl}) = _PawnService;

  @GET(ApiConstants.GET_LIST_PAWN)
  Future<PawnListResponse> getListPawn();
}
