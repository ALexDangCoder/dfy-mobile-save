import 'package:Dfy/data/response/market_place/login/login_response.dart';
import 'package:Dfy/data/response/market_place/login/nonce_response.dart';
import 'package:Dfy/data/response/market_place/login/otp_response.dart';
import 'package:Dfy/data/response/market_place/login/user_profile.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/login_service.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/nonce_model.dart';
import 'package:Dfy/domain/model/market_place/otp_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
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

  @override
  Future<Result<ProfileModel>> getUserProfile() {
    return runCatchingAsync<ProfileResponse, ProfileModel>(
      () => _loginClient.getUserProfile(),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<LoginModel>> refreshToken(String refreshToken) {
    return runCatchingAsync<LoginResponse, LoginModel>(
      () => _loginClient.refreshToken(refreshToken),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<OTPModel>> sendOTP(String email, int type) {
    return runCatchingAsync<OTPResponse, OTPModel>(
      () => _loginClient.getOTP(email, type),
      (response) => response.toDomain(),
    );
  }

  @override
  Future<Result<LoginModel>> verifyOTP(String otp, String transactionId) {
    return runCatchingAsync<LoginResponse, LoginModel>(
      () => _loginClient.verifyOTP(otp, transactionId),
      (response) => response.toDomain(),
    );
  }
}
