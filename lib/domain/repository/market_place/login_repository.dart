import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/nonce_model.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';

mixin LoginRepository {
  Future<Result<LoginModel>> login(String signature,String walletAddress);

  Future<Result<NonceModel>> getNonce(String walletAddress);

  Future<Result<ProfileModel>> getUserProfile();

  Future<Result<LoginModel>> refreshToken(String refreshToken);

}