import 'package:Dfy/data/response/market_place/login/login_response.dart';
import 'package:Dfy/data/response/market_place/nonce/nonce_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/login_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/nonce_model.dart';
import 'package:Dfy/domain/repository/market_place/login_repository.dart';

class LoginImpl implements LoginRepository {
  final LoginClient _loginClient;

  LoginImpl(this._loginClient);

  @override
  Future<Result<LoginModel>> login(String signature, String walletAddress) {
    return runCatchingAsync<LoginResponse, LoginModel>(
      () => _loginClient.login(signature, walletAddress),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<NonceModel>> getNonce(String walletAddress) {
    return runCatchingAsync<NonceResponse, NonceModel>(
          () => _loginClient.getNonce(walletAddress),
          (response) => response.toDomain(),
    );
  }
}
