import 'package:Dfy/data/response/create_hard_nft/evaluation_fee_response.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluators_response.dart';
import 'package:Dfy/data/response/create_hard_nft/list_appointment_response.dart';
import 'package:Dfy/data/response/create_hard_nft/list_evaluators_city_response.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';

part 'create_hard_nft_service.g.dart';

@RestApi()
abstract class CreateHardNFtService {
  @factoryMethod
  factory CreateHardNFtService(Dio dio, {String baseUrl}) =
      _CreateHardNFtService;

  @GET(ApiConstants.GET_LIST_APPOINTMENTS)
  Future<ListAppointmentResponse> getListAppointments(
    @Query('asset_id') String assetId,
  );

  @GET(ApiConstants.GET_LIST_EVALUATORS_CITY)
  Future<ListEvaluatorsCityResponse> getListEvaluatorsCity(
    @Query('city_id') int cityId,
  );

  @GET(
      '${ApiConstants.GET_EVALUATORS_DETAIL}{evaluator_id}${ApiConstants.GET_EVALUATORS_DETAIL_END}')
  Future<EvaluatorsDetailResponse> getEvaluatorsDetail(
    @Path('evaluator_id') String evaluatorId,
  );

  @GET(ApiConstants.GET_EVALUATION_FEE)
  Future<EvaluationFeeListResponse> getEvaluationFee();
}
