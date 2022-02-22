import 'package:Dfy/data/response/create_hard_nft/confirm_evaluation_response.dart';
import 'package:Dfy/data/response/create_hard_nft/detail_asset_hard_nft_response.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluation_result.dart';
import 'package:Dfy/data/response/create_hard_nft/cancel_evaluation.dart';
import 'package:Dfy/data/response/create_hard_nft/create_evaluation_response.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluation_fee_response.dart';
import 'package:Dfy/data/response/create_hard_nft/evaluators_response.dart';
import 'package:Dfy/data/response/create_hard_nft/list_appointment_response.dart';
import 'package:Dfy/data/response/create_hard_nft/list_evaluators_city_response.dart';
import 'package:Dfy/data/response/create_hard_nft/list_mint_request_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/create_hard_nft_service.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/domain/model/market_place/cancel_evaluation_model.dart';
import 'package:Dfy/domain/model/market_place/create_evaluation_model.dart';
import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/market_place/evaluation_fee.dart';
import 'package:Dfy/domain/model/market_place/evaluation_result.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';
import 'package:Dfy/domain/repository/market_place/create_hard_nft_repository.dart';
import 'package:Dfy/utils/constants/api_constants.dart';

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
    int assetTypeId,
  ) {
    return runCatchingAsync<ListEvaluatorsCityResponse,
        List<EvaluatorsCityModel>>(
      () => _client.getListEvaluatorsCity(
        cityId,
        assetTypeId,
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

  @override
  Future<Result<CreateEvaluationModel>> createEvaluation(
    int appointmentTime,
    String assetId,
    String bcTxnHash,
    String evaluatorAddress,
    String evaluatorId,
  ) {
    return runCatchingAsync<CreateEvaluationResponse, CreateEvaluationModel>(
      () => _client.createEvaluation(
        appointmentTime,
        assetId,
        bcTxnHash,
        evaluatorAddress,
        evaluatorId,
      ),
      (response) => response.item?.toDomain() ?? CreateEvaluationModel(),
    );
  }

  @override
  Future<Result<List<EvaluationResult>>> getListEvaluationResult(
    String assetId,
    String page,
  ) {
    return runCatchingAsync<EvaluationResultResponse, List<EvaluationResult>>(
      () => _client.getListEvaluationResult(
        assetId,
        page,
        ApiConstants.DEFAULT_NFT_SIZE,
      ),
      (response) => response.toDomain() ?? [],
    );
  }

  @override
  Future<Result<String>> confirmAcceptEvaluationToBE(
    String bcTxnHash,
    String evaluationID,
  ) {
    return runCatchingAsync<ConfirmEvaluationResponse, String>(
      () => _client.confirmAcceptEvaluation(
        evaluationID,
        bcTxnHash,
      ),
      (response) => response.code ?? '',
    );
  }

  @override
  Future<Result<String>> confirmRejectEvaluationToBE(
    String bcTxnHash,
    String evaluationID,
  ) {
    return runCatchingAsync<ConfirmEvaluationResponse, String>(
      () => _client.confirmRejectEvaluation(
        evaluationID,
        bcTxnHash,
      ),
      (response) => response.code ?? '',
    );
  }

  @override
  Future<Result<DetailAssetHardNft>> getDetailAssetHardNFT(String assetId) {
    return runCatchingAsync<DetailAssetHardNftResponse, DetailAssetHardNft>(
      () => _client.getDetailAssetHardNFT(assetId),
      (response) => response.item?.toDomain() ?? DetailAssetHardNft(),
    );
  }

  @override
  Future<Result<List<MintRequestModel>>> getListMintRequestHardNFT(
    String name,
    String status,
    String assetTypeId,
    String page,
    String limit,
  ) {
    return runCatchingAsync<ListMintRequestResponse, List<MintRequestModel>>(
      () => _client.getMintRequestHardNFT(
        name,
        assetTypeId,
        status,
        page,
        ApiConstants.DEFAULT_NFT_SIZE,
      ),
      (response) => response.toDomain() ?? [],
    );
  }
}
