import 'package:Dfy/data/response/collection_filter/list_response_call_api.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/collection_filter_service.dart';
import 'package:Dfy/domain/model/collection_filter.dart';
import 'package:Dfy/domain/repository/market_place/collection_filter_repo.dart';

class CollectionFilterImpl implements CollectionFilterRepository {

  final CollectionFilterClient _client;

  CollectionFilterImpl(this._client);

  @override
  Future<Result<List<CollectionFilter>>> getListCollection() {
    return runCatchingAsync<ListResponseFromApi, List<CollectionFilter>>(
          () => _client.getListCollection(),
          (response) => response.toDomain() ?? [],
    );
  }

}