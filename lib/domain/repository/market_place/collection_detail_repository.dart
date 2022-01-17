import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/market_place/collection_detail_filter_model.dart';

mixin CollectionDetailRepository {
  Future<Result<CollectionDetailModel>> getCollectionDetail(
    String id,
  );

  Future<Result<List<ActivityCollectionModel>>> getCollectionListActivity(
    String collectionAddress,
    String type,
    int page,
    int size,
  );
  Future<Result<List<CollectionFilterDetailModel>>> getListFilterCollectionDetail({
    String? collectionAddress,
  });
}
