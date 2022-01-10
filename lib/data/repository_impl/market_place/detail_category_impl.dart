import 'package:Dfy/data/response/market_place/detail_category_res.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/detail_category_service.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/market_place/list_collection_detail_model.dart';
import 'package:Dfy/domain/repository/market_place/detail_category_repository.dart';

class DetailCategoryRepositoryImpl implements DetailCategoryRepository {
  final DetailCategoryClient _detailCategoryService;

  DetailCategoryRepositoryImpl(
    this._detailCategoryService,
  );

  @override
  Future<Result<ListCollectionDetailModel>> getListCollectInCategory(
    int size,
    String category,
    int page,
  ) {
    return runCatchingAsync<DetailCategoryResponse, ListCollectionDetailModel>(
      () => _detailCategoryService.getListCollectInCategory(
        size,
        category,
        page,
      ),
      (response) => response.toDomain(),
    );
  }
}
