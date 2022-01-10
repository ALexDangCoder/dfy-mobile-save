import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/list_collection_detail_model.dart';

mixin DetailCategoryRepository{
  Future<Result<ListCollectionDetailModel>> getListCollectInCategory(
      int size,
      String category,
      int page,
      );
}