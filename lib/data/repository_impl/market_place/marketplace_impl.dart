import 'package:Dfy/data/response/market_place/market_place_res.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/marketplace_client.dart';
import 'package:Dfy/domain/model/market_place/list_type_nft_collection_explore_model.dart';
import 'package:Dfy/domain/repository/market_place/list_type_nft_collection_explore_repository.dart';

class MarketPlaceImpl implements MarketPlaceRepository {
  final MarketPlaceHomeClient _client;

  MarketPlaceImpl(this._client);

  @override
  Future<Result<List<ListTypeNftCollectionExploreModel>>>
      getListTypeNftCollectionExplore() {
    return runCatchingAsync<MarketPlaceResponse,
        List<ListTypeNftCollectionExploreModel>>(
      () => _client.getListNftCollectionExplore(),
      (response) => response.toDomain() ?? [],
    );
  }
}
