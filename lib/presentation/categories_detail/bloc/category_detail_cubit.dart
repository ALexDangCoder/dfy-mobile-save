import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/base/base_state.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/market_place/list_collection_detail_model.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/domain/repository/market_place/detail_category_repository.dart';
import 'package:Dfy/presentation/categories_detail/bloc/category_detail_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

class CategoryDetailCubit extends BaseCubit<CategoryState> {
  CategoryDetailCubit() : super(LoadingCategoryState());

  int nextPage = 1;

  CategoryRepository get _categoryService => Get.find();

  DetailCategoryRepository get _detailCategoryService => Get.find();

  final BehaviorSubject<List<CollectionDetailModel>> _listCollectionSubject =
      BehaviorSubject<List<CollectionDetailModel>>();
  final BehaviorSubject<Category> _categorySubject =
      BehaviorSubject<Category>();
  final BehaviorSubject<bool> _canLoadMoreSubject = BehaviorSubject<bool>();

  Stream<List<CollectionDetailModel>> get listCollectionStream =>
      _listCollectionSubject.stream;

  Stream<Category> get categoryStream => _categorySubject.stream;

  Stream<bool> get canLoadMoreStream => _canLoadMoreSubject.stream;

  Future<void> getListCollection(String id) async {
    final Result<ListCollectionDetailModel> result =
        await _detailCategoryService.getListCollectInCategory(10, id, nextPage);
    result.map(
      success: (result) {
        final List<CollectionDetailModel> currentList =
            _listCollectionSubject.valueOrNull ?? [];
        if (result.data.listData.isNotEmpty) {
          _listCollectionSubject.sink
              .add([...currentList, ...result.data.listData]);
        }
        if (currentList.length + result.data.listData.length ==
            result.data.total) {
          _canLoadMoreSubject.sink.add(false);
        }
        nextPage++;
      },
      error: (error) {
        //print(error);
      },
    );
  }

  Future<void> getCategory(String id) async {
    emit(LoadingCategoryState());
    final result = await _categoryService.getCategory(id);
    result.when(
      success: (response) {
        if (response.isNotEmpty) {
          _categorySubject.sink.add(response.first);
          emit(LoadedCategoryState());
        }
        else {
          emit(ErrorCategoryState());
        }
      },
      error: (error) {
        emit(ErrorCategoryState());
      },
    );
  }

  void dispose() {
    _categorySubject.close();
    _listCollectionSubject.close();
  }

  Future<void> getData(String id) async {
    await getCategory(id);
    await getListCollection(id);
  }
}
