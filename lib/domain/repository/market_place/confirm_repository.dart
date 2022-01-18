import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/confirm_model.dart';

mixin ConfirmRepository {
  Future<Result<ConfirmModel>> getCancelSaleResponse({
    required String id,
    required String txnHash,
  });

  Future<Result<ConfirmModel>> createSoftCollection({
    required CreateSoftCollectionRequest data,
  });

  Future<Result<ConfirmModel>> createHardCollection({
    required CreateHardCollectionRequest data,
  });
}
