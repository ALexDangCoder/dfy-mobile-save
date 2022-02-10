import 'package:Dfy/data/response/create_hard_nft/cancel_evaluation.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluation_fee_response.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluators_response.dart';
import 'package:Dfy/data/response/create_hard_nft/list_appointment_response.dart';
import 'package:Dfy/data/response/create_hard_nft/list_evaluators_city_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/create_hard_nft_service.dart';
import 'package:Dfy/domain/model/market_place/cancel_evaluation_model.dart';
import 'package:Dfy/domain/model/market_place/evaluation_fee.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';

class CreateHardNFTImpl implements CreateHardNFTRepository {
  final CreateHardNFtService _client;

  CreateHardNFTImpl(this._client);

  @override
  Future<Result<List<AppointmentModel>>> getListAppointment(String assetId) {
    return runCatchingAsync<ListAppointmentResponse, List<AppointmentModel>>(
      () => _client.getListAppointments(
        assetId,
      ),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<List<EvaluatorsCityModel>>> getListAppointmentWithCity(
    int cityId,
  ) {
    return runCatchingAsync<ListEvaluatorsCityResponse,
        List<EvaluatorsCityModel>>(
      () => _client.getListEvaluatorsCity(
        cityId,
      ),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  @override
  Future<Result<EvaluatorsDetailModel>> getEvaluatorsDetail(
    String evaluatorID,
  ) {
    return runCatchingAsync<EvaluatorsDetailResponse, EvaluatorsDetailModel>(
      () => _client.getEvaluatorsDetail(
        evaluatorID,
      ),
      (response) => response.item?.toDomain() ?? EvaluatorsDetailModel(),
    );
  }

  @override
  Future<Result<List<EvaluationFee>>> getEvaluationFee() {
    return runCatchingAsync<EvaluationFeeListResponse, List<EvaluationFee>>(
      () => _client.getEvaluationFee(),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }

  // @override
  // Future<Result<List<EvaluationFee>>> createEvaluation() {
  // return runCatchingAsync<EvaluationFeeListResponse, List<EvaluationFee>>(
  //       () => _client.getEvaluationFee(),
  //       (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
  // );
//  }

  @override
  Future<Result<CancelEvaluationModel>> cancelEvaluation(
    String evaluatorId,
    String bcTxnHashCancel,
  ) {
    return runCatchingAsync<CancelEvaluationResponse, CancelEvaluationModel>(
      () => _client.cancelEvaluation(evaluatorId, bcTxnHashCancel),
      (response) => response.item?.toDomain() ?? CancelEvaluationModel(),
    );
  }
}
