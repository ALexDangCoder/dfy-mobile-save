import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/confirm_model.dart';

mixin ConfirmRepository {
  Future<Result<ConfirmModel>> getCancelSaleResponse({
    required String id,
    required String txnHash,
  });
}
