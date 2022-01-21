import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/data/request/put_on_market/put_on_sale_request.dart';
import 'package:Dfy/data/response/market_place/confirm_res.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/confirm_service.dart';
import 'package:Dfy/domain/model/market_place/confirm_model.dart';
import 'package:Dfy/domain/repository/market_place/confirm_repository.dart';

class ConfirmImplement implements ConfirmRepository {
  final ConfirmClient _confirmClient;

  ConfirmImplement(this._confirmClient);

  @override
  Future<Result<ConfirmModel>> getCancelSaleResponse({
    required String id,
    required String txnHash,
  }) {
    return runCatchingAsync<ConfirmResponse, ConfirmModel>(
      () => _confirmClient.cancelSale(id, txnHash),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<ConfirmModel>> createSoftCollection(
      {required CreateSoftCollectionRequest data}) {
    return runCatchingAsync<ConfirmResponse, ConfirmModel>(
      () => _confirmClient.createSoftCollection(data),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<ConfirmModel>> createHardCollection(
      {required CreateHardCollectionRequest data}) {
    return runCatchingAsync<ConfirmResponse, ConfirmModel>(
      () => _confirmClient.createHardCollection(data),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<ConfirmModel>> putOnSale({required PutOnSaleRequest data}) {
    return runCatchingAsync<ConfirmResponse, ConfirmModel>(
          () => _confirmClient.putOnSale(data),
          (response) => response.toDomain(),
    );
  }
}
