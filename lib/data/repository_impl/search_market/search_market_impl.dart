import 'package:Dfy/data/response/search_market/search_market_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/search_market/search_market_client.dart';
import 'package:Dfy/domain/model/search_marketplace/list_search_collection_nft_model.dart';
import 'package:Dfy/domain/repository/search_market/search_market_repository.dart';

class SearchMarketImpl implements SearchMarketRepository {
  final SearchMarketClient _client;

  SearchMarketImpl(this._client);

  @override
  Future<Result<List<ListSearchCollectionFtNftModel>>>
      getCollectionFeatNftSearch({String? name}) {
    return runCatchingAsync<SearchMarketResponse,
        List<ListSearchCollectionFtNftModel>>(
      () => _client.getCollectionFeatNftSearch(name),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
