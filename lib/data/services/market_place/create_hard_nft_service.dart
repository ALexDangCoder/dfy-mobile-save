import 'package:Dfy/data/response/create_hard_nft/confirm_evaluation_response.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluation_result.dart';
import 'package:Dfy/data/response/create_hard_nft/cancel_evaluation.dart';
import 'package:Dfy/data/response/create_hard_nft/create_evaluation_response.dart';
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

  @GET(ApiConstants.GET_LIST_EVALUATION_RESULT)
  Future<EvaluationResultResponse> getListEvaluationResult(
    @Query('asset_id') String assetId,
    @Query('page') String? page,
    @Query('size') String? size,
  );

  @PUT(
      '${ApiConstants.GET_LIST_EVALUATION_RESULT}{evaluator_id}${ApiConstants.ACCEPT}')
  Future<ConfirmEvaluationResponse> confirmAcceptEvaluation(
    @Path('evaluator_id') String evaluatorId,
    @Query('bc_txn_hash_accept') String bcTxnHash,
  );
  @PUT(
      '${ApiConstants.GET_LIST_EVALUATION_RESULT}{evaluator_id}${ApiConstants.REJECT}')
  Future<ConfirmEvaluationResponse> confirmRejectEvaluation(
      @Path('evaluator_id') String evaluatorId,
      @Query('bc_txn_hash_accept') String bcTxnHash,
      );


  @GET(ApiConstants.GET_EVALUATION_FEE)
  Future<EvaluationFeeListResponse> getEvaluationFee();

  @POST(ApiConstants.CREATE_EVALUATION)
  Future<CreateEvaluationResponse> createEvaluation(
    @Field('appointment_time') int appointmentTime,
    @Field('asset_id') String assetId,
    @Field('bc_txn_hash') String bcTxnHash,
    @Field('evaluator_address') String evaluatorAddress,
    @Field('evaluator_id') String evaluatorId,
  );

  @PUT('${ApiConstants.CANCEL}{evaluator_id}${ApiConstants.CANCEL_END}')
  Future<CancelEvaluationResponse> cancelEvaluation(
    @Path('evaluator_id') String evaluatorId,
    @Query('bc_txn_hash_cancel') String bcTxnHashCancel,
  );
}
