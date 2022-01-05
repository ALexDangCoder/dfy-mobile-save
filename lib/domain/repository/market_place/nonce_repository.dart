import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/nonce_model.dart';

mixin NonceRepository {
  Future<Result<NonceModel>> getNonce(String walletAddress);
}