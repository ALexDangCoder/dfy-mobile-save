
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/token_model.dart';

mixin TokenRepository {
  Future<Result<List<TokenModel>>> getListToken();
}

