

import 'package:Dfy/data/response/collection/collection_response.dart';
import 'package:Dfy/data/result/result.dart';

mixin CollectionRepository {
  Future<Result<List<CollectionResponse>>> getCollection();
}
