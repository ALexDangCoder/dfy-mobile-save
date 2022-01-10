import 'package:Dfy/data/services/market_place/detail_category_service.dart';
import 'package:Dfy/domain/repository/market_place/detail_category_repository.dart';

class DetailCategoryRepositoryImpl implements DetailCategoryRepository {


  final DetailCategoryClient _detailCategoryService;

  DetailCategoryRepositoryImpl(
      this._detailCategoryService,
      );

}