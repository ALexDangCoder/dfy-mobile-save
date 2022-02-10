
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/model/token_price_model.dart';

mixin TokenRepository {
  Future<Result<List<TokenInf>>> getListToken();
  Future<Result<List<TokenPrice>>> getListPriceToken(String symbols);
}

