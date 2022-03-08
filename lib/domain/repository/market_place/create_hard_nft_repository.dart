import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/hard_nft_my_account/hard_nft_mint_request.dart';
import 'package:Dfy/domain/model/market_place/detail_asset_hard_nft.dart';
import 'package:Dfy/domain/model/market_place/evaluation_result.dart';
import 'package:Dfy/domain/model/market_place/cancel_evaluation_model.dart';
import 'package:Dfy/domain/model/market_place/create_evaluation_model.dart';
import 'package:Dfy/domain/model/market_place/evaluation_fee.dart';
import 'package:Dfy/domain/model/market_place/evaluator_detail.dart';
import 'package:Dfy/domain/model/market_place/evaluators_city_model.dart';
import 'package:Dfy/domain/model/market_place/pawn_shop_model.dart';

mixin CreateHardNFTRepository {
  Future<Result<List<AppointmentModel>>> getListAppointment(
    String assetId,
  );

  Future<Result<List<EvaluatorsCityModel>>> getListAppointmentWithCity(
    int cityId,
    int assetTypeId,
  );

  Future<Result<EvaluatorsDetailModel>> getEvaluatorsDetail(
    String evaluatorID,
  );

  Future<Result<List<EvaluationFee>>> getEvaluationFee();

  Future<Result<CreateEvaluationModel>> createEvaluation(
    int appointmentTime,
    String assetId,
    String bcTxnHash,
    String evaluatorAddress,
    String evaluatorId,
  );

  Future<Result<CancelEvaluationModel>> cancelEvaluation(
    String evaluatorId,
    String bcTxnHashCancel,
  );

  Future<Result<List<EvaluationResult>>> getListEvaluationResult(
    String assetId,
    String page,
  );

  Future<Result<String>> confirmRejectEvaluationToBE(
    String bcTxnHash,
    String evaluationID,
  );

  Future<Result<String>> confirmAcceptEvaluationToBE(
    String bcTxnHash,
    String evaluationID,
  );

  Future<Result<String>> confirmTransferNftToBE(
      Map<String,String> map
      );

  Future<Result<DetailAssetHardNft>> getDetailAssetHardNFT(
    String assetId,
  );

  Future<Result<List<MintRequestModel>>> getListMintRequestHardNFT(
    String name,
    String status,
    String assetTypeId,
    String page,
  );
}
