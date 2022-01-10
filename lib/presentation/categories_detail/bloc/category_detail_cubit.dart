import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/domain/repository/market_place/detail_category_repository.dart';
import 'package:Dfy/presentation/categories_detail/bloc/category_detail_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class CategoryDetailCubit extends BaseCubit<CategoryState> {
  CategoryDetailCubit() : super(CategoryStateInitState());

  int nextPage = 1;
  bool canLoadMore = true;

  CategoryRepository get _categoryService => Get.find();

  DetailCategoryRepository get _detailCategoryService => Get.find();

  final BehaviorSubject<List<CollectionDetailModel>> _listCollectionSubject =
      BehaviorSubject<List<CollectionDetailModel>>();
  final BehaviorSubject<Category> _categorySubject =
      BehaviorSubject<Category>();

  Stream<List<CollectionDetailModel>> get listCollectionStream =>
      _listCollectionSubject.stream;

  Stream<Category> get categoryStream => _categorySubject.stream;

  Future<void> getListCollection(String id) async {
    final Result<List<CollectionDetailModel>> result =
        await _detailCategoryService.getListCollectInCategory(
      5,
      id,
      nextPage,
    );
    result.map(
      success: (result) {
        final List<CollectionDetailModel> currentList =
            _listCollectionSubject.valueOrNull ?? [];
        if (result.data.isNotEmpty) {
          _listCollectionSubject.sink.add([...currentList, ...result.data]);
        } else {
          canLoadMore = false;
        }
        nextPage++;
      },
      error: (error) {
        print(error);
      },
    );
  }

  Future<void> getCategory(String id) async {
    showLoading();
    final result = await _categoryService.getCategory(id);
    result.when(success: (response) {
      if (response.isNotEmpty) {
        _categorySubject.sink.add(response.first);
      }
    }, error: (error) {
      print(error);
    });
    showContent();
  }

  void dispose() {
    _categorySubject.close();
    _listCollectionSubject.close();
  }

  Future<void> getData(String id) async {
    await getListCollection(id);
    await getCategory(id);
  }
}
