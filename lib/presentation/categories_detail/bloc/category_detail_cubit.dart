import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/repository/market_place/detail_category_repository.dart';
import 'package:Dfy/presentation/categories_detail/bloc/category_detail_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class CategoryDetailCubit extends BaseCubit<CategoryState> {
  CategoryDetailCubit() : super(CategoryStateInitState());

  DetailCategoryRepository get _detailCategoryService => Get.find();

  final BehaviorSubject<List<CollectionDetailModel>> _listCollectionSubject =
      BehaviorSubject<List<CollectionDetailModel>>();

  Stream<List<CollectionDetailModel>> get listCollectionStream =>
      _listCollectionSubject.stream;

  Future<void> getListCollection(String id) async {
    final Result<List<CollectionDetailModel>> result =
        await _detailCategoryService.getListCollectInCategory(
      20,
      id,
      1,
    );
    result.map(
      success: (result) {
        _listCollectionSubject.sink.add(result.data);
      },
      error: (error) {
        print(error);
      },
    );
  }

  void dispose() {}
}
