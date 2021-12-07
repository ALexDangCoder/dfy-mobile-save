import 'package:Dfy/data/response/token/list_token_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/token_model.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:Dfy/data/services/token_service.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenClient _tokenClient;

  TokenRepositoryImpl(
    this._tokenClient,
  );

  @override
  Future<Result<List<TokenModel>>> getListToken() {
    return runCatchingAsync<ListTokenResponse, List<TokenModel>>(
      () => _tokenClient.getListToken(),
      (response) => response.toDomain(),
    );
  }
}
