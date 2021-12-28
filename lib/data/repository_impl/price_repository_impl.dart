import 'package:Dfy/data/response/token/list_price_token_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/price_service.dart';
import 'package:Dfy/domain/model/token_price_model.dart';
import 'package:Dfy/domain/repository/price_repository.dart';

class PriceRepositoryImpl implements PriceRepository {
  final PriceClient _priceClient;

  PriceRepositoryImpl(
    this._priceClient,
  );

  @override
  Future<Result<List<TokenPrice>>> getListPriceToken(String symbols) {
    return runCatchingAsync<ListPriceTokenResponse, List<TokenPrice>>(
      () => _priceClient.getListPriceToken(symbols),
      (response) => response.toDomain() ?? [],
    );
  }
}
