
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/token_price_model.dart';

mixin PriceRepository {
  Future<Result<List<TokenPrice>>> getListPriceToken(String symbols);
}

