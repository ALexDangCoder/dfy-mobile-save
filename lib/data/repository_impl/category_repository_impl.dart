import 'package:Dfy/data/response/collection/list_category_response.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/services/market_place/category_service.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryService _categoryService;

  CategoryRepositoryImpl(
    this._categoryService,
  );

  @override
  Future<Result<List<Category>>> getListCategory() {
    return runCatchingAsync<ListCategoryResponse, List<Category>>(
      () => _categoryService.getListCategory(),
      (response) => response.rows?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
