import 'package:Dfy/data/response/activity_collection/activity_collection.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_filter_response.dart';
import 'package:Dfy/data/response/collection_detail/collection_detail_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/collection_detail_service.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/market_place/collection_detail_filter_model.dart';
import 'package:Dfy/domain/repository/market_place/collection_detail_repository.dart';

class CollectionDetailImpl implements CollectionDetailRepository {
  final CollectionDetailService _client;

  CollectionDetailImpl(this._client);

  @override
  Future<Result<CollectionDetailModel>> getCollectionDetail(
      String collectionAddress,) {
    return runCatchingAsync<CollectionDetailResponse, CollectionDetailModel>(
      () => _client.getCollection(collectionAddress),
      (response) => response.item?.toDomain() ?? CollectionDetailModel(),
    );
  }

  @override
  Future<Result<List<ActivityCollectionModel>>> getCollectionListActivity(
      String collectionAddress, String type, int page, int size,) {
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

  @override
  Future<Result<List<CollectionFilterDetailModel>>>
  getListFilterCollectionDetail({String? collectionAddress}) {
    return runCatchingAsync<CollectionDetailFilterResponse,
        List<CollectionFilterDetailModel>>(
          () => _client.getListFilterCollectionDetail(collectionAddress),
          (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
