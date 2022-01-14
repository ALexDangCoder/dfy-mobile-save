import 'package:Dfy/data/response/market_place/confirm_res.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/confirm_service.dart';
import 'package:Dfy/domain/model/market_place/confirm_model.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';

class ConfirmImplement implements ConfirmRepository {
  final ConfirmClient _confirmClient;

  ConfirmImplement(this._confirmClient);

  @override
  Future<Result<ConfirmModel>> getCancelSaleResponse(
      {required String id, required String txnHash,}) {
    return runCatchingAsync<ConfirmResponse, ConfirmModel>(
          () => _confirmClient.cancelSale(id, txnHash),
          (response) => response.toDomain(),
    );  }
}