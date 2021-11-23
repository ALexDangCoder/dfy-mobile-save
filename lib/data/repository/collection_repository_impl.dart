
import 'package:Dfy/data/response/collection/collection_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/collection_service.dart';
import 'package:Dfy/domain/repository/collection_repository.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionClient _collectionService;

  CollectionRepositoryImpl(
    this._collectionService,
  );

  @override
  Future<Result<List<CollectionRespone>>> getCollection() {
    return runCatchingAsync(() => _collectionService.getCollection(),);
  }
}
