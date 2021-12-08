import 'package:Dfy/data/response/token/list_token_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/token_service.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/token_repository.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenClient _tokenClient;

  TokenRepositoryImpl(
    this._tokenClient,
  );

  @override
  Future<Result<List<TokenInf>>> getListToken() {
    return runCatchingAsync<ListTokenResponse, List<TokenInf>>(
      () => _tokenClient.getListToken(),
      (response) => response.toDomain() ?? [],
    );
  }
}
