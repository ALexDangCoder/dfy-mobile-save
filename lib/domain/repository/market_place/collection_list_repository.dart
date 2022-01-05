import 'package:Dfy/data/response/collection/collection_res.dart';
import 'package:Dfy/data/result/result.dart';

mixin CollectionListRepository {
  Future<Result<List<ListCollectionResponse>>> getListCollection();
}
