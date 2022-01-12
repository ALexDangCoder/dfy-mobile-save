import 'package:Dfy/data/response/nonce/nonce_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/nonce_service.dart';
import 'package:Dfy/domain/model/market_place/nonce_model.dart';
import 'package:Dfy/domain/repository/market_place/nonce_repository.dart';

class NonceImpl implements NonceRepository {
  final NonceClient _nonceClient;

  NonceImpl(this._nonceClient);

  @override
  Future<Result<NonceModel>> getNonce(String walletAddress) {
    return runCatchingAsync<NonceResponse, NonceModel>(
      () => _nonceClient.getNonce(walletAddress),
      (response) => response.toDomain(),
    );
  }
}
