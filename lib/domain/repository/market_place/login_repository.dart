import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/login_model.dart';

mixin LoginRepository {
  Future<Result<LoginModel>> login(String signature,String walletAddress);
}