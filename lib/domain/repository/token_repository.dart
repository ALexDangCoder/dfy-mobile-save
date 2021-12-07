
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/token_inf.dart';

mixin TokenRepository {
  Future<Result<List<TokenInf>>> getListToken();
}

