
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/collection_filter.dart';

mixin CollectionFilterRepository {
  Future<Result<List<CollectionFilter>>> getListCollection();
}
