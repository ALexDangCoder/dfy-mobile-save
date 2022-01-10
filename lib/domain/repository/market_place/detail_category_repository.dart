import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';

mixin DetailCategoryRepository{
  Future<Result<List<CollectionDetailModel>>> getListCollectInCategory(
      int size,
      String category,
      int page,
      );
}