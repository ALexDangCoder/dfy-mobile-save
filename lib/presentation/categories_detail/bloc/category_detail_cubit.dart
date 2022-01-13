import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/market_place/category_model.dart';
import 'package:Dfy/domain/model/market_place/collection_categories_model.dart';
import 'package:Dfy/domain/model/market_place/collection_detail.dart';
import 'package:Dfy/domain/model/market_place/list_collection_detail_model.dart';
import 'package:Dfy/domain/repository/market_place/category_repository.dart';
import 'package:Dfy/domain/repository/market_place/detail_category_repository.dart';
import 'package:Dfy/presentation/categories_detail/bloc/category_detail_state.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:rxdart/rxdart.dart';

enum LoadMoreType {
  CAN_LOAD_MORE,
  LOAD_MORE_FAIL,
  NOT_CAN_LOAD_MORE,
}


class CategoryDetailCubit extends BaseCubit<CategoryState> {
  CategoryDetailCubit() : super(LoadingCategoryState());

  int nextPage = 1;
  bool loading = false;

  CategoryRepository get _categoryService => Get.find();

  DetailCategoryRepository get _detailCategoryService => Get.find();

  final BehaviorSubject<List<CollectionCategoryModel>> _listCollectionSubject =
      BehaviorSubject<List<CollectionCategoryModel>>();
  final BehaviorSubject<Category> _categorySubject =
      BehaviorSubject<Category>();
  final BehaviorSubject<LoadMoreType> canLoadMoreSubject = BehaviorSubject<LoadMoreType>();

  Stream<List<CollectionCategoryModel>> get listCollectionStream =>
      _listCollectionSubject.stream;

  Stream<Category> get categoryStream => _categorySubject.stream;

  Stream<LoadMoreType> get canLoadMoreStream => canLoadMoreSubject.stream;

  Future<void> getListCollection(String id) async {
    if (state is! ErrorCategoryState && loading == false){
      loading = true;
      final Result<ListCollectionDetailModel> result =
      await _detailCategoryService.getListCollectInCategory(1, id, nextPage);
      result.map(
        success: (result) {
          final List<CollectionCategoryModel> currentList =
              _listCollectionSubject.valueOrNull ?? [];
          if (result.data.listData.isNotEmpty) {
            _listCollectionSubject.sink
                .add([...currentList, ...result.data.listData]);
          }
          if (currentList.length + result.data.listData.length ==
              result.data.total) {
            canLoadMoreSubject.sink.add(LoadMoreType.NOT_CAN_LOAD_MORE);
          }
          emit(LoadListCollectionSuccessState());
          nextPage++;
        },
        error: (error) {
          emit(LoadListCollectionFailState());
          canLoadMoreSubject.sink.add(LoadMoreType.LOAD_MORE_FAIL);
        },
      );
      loading = false;
    }
  }

  Future<void> getCategory(String id) async {
    emit(LoadingCategoryState());
    final result = await _categoryService.getCategory(id);
    result.when(
      success: (response) {
        if (response.isNotEmpty) {
          _categorySubject.sink.add(response.first);
          emit(LoadingListCollectionState());
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
    nextPage = 1;
    _listCollectionSubject.sink.add([]);
    canLoadMoreSubject.sink.add(LoadMoreType.CAN_LOAD_MORE);
    await getCategory(id);
    await getListCollection(id);
  }
}
