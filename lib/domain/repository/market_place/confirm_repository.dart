import 'package:Dfy/data/request/collection/create_hard_collection_request.dart';
import 'package:Dfy/data/request/collection/create_soft_collection_request.dart';
import 'package:Dfy/data/request/put_on_market/put_on_sale_request.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/confirm_model.dart';

mixin ConfirmRepository {


  Future<Result<ConfirmModel>> createSoftCollection({
    required CreateSoftCollectionRequest data,
  });

  Future<Result<ConfirmModel>> createHardCollection({
    required CreateHardCollectionRequest data,
  });

  Future<Result<ConfirmModel>> putOnSale({
    required PutOnSaleRequest data,
  });
}
