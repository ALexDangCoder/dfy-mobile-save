import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/cancel_evaluation_model.dart';
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
  );

  Future<Result<EvaluatorsDetailModel>> getEvaluatorsDetail(
    String evaluatorID,
  );

  Future<Result<List<EvaluationFee>>> getEvaluationFee();

  // Future<Result<List<EvaluationFee>>> createEvaluation(
  //   int? appointmentTime,
  //   String? assetId,
  //   String? bcTxnHash,
  //   String? evaluatorAddress,
  //   String? evaluatorId,
  // );

  Future<Result<CancelEvaluationModel>> cancelEvaluation(
    String evaluatorId,
    String bcTxnHashCancel,
  );
}
