import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';

mixin NftCollectionExploreRepository {
  Future<Result<List<Category>>> getListCategory();
}
