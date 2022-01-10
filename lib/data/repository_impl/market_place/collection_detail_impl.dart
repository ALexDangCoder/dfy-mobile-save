import 'package:Dfy/data/response/activity_collection/activity_collection.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/collection_detail_service.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';

class CollectionDetailImpl implements CollectionDetailRepository {
  final CollectionDetailService _client;

  CollectionDetailImpl(this._client);

  @override
  Future<Result<CollectionDetailModel>> getCollectionDetail(String id) {
    return runCatchingAsync<CollectionDetailResponse, CollectionDetailModel>(
      () => _client.getCollection(id),
      (response) => response.item?.toDomain() ?? CollectionDetailModel(),
    );
  }

  @override
  Future<Result<List<ActivityCollectionModel>>> getCollectionListActivity(
      String collectionAddress, String type, int page, int size) {
    return runCatchingAsync<ActivityCollectionResponse,
        List<ActivityCollectionModel>>(
      () => _client.getListActivityCollection(
        collectionAddress,
        type,
        page,
        size,
      ),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
