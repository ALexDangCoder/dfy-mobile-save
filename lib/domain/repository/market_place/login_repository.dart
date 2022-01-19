import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';
import 'package:Dfy/domain/model/market_place/nonce_model.dart';

mixin LoginRepository {
  Future<Result<LoginModel>> login(String signature,String walletAddress);

  Future<Result<NonceModel>> getNonce(String walletAddress);

  Future<Result<NonceModel>> getUserProfile();

}