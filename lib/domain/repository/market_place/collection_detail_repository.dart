import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/activity_collection_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';

mixin CollectionDetailRepository {
  Future<Result<CollectionDetailModel>> getCollectionDetail(
    String id,
  );

  Future<Result< List<ActivityCollectionModel>>> getCollectionListActivity(
    String collectionAddress,
    String status,
  );
}
