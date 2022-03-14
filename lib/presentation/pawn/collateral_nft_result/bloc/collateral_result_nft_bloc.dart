import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/nft_market_place.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'collateral_result_nft_state.dart';

class CollateralResultNFTBloc extends BaseCubit<CollateralResultNFTState> {
  CollateralResultNFTBloc() : super(CollateralResultInitial());

  BehaviorSubject<String> textSearch = BehaviorSubject.seeded('');
  List<NftMarket> list = [];
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;

  //
  String mess = '';

  BorrowRepository get _pawnService => Get.find();

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getListCollateral();
    }
  }

  void funOnSearch(String value) {
    textSearch.sink.add(value);
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getListCollateral();
    }
  }

  Future<void> getListCollateral() async {
    showLoading();
    emit(CollateralResultLoading());
    final Result<List<NftMarket>> response =
        await _pawnService.getListNFTCollateral(
      page: page.toString(),
      size: '12',
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        _isLoading = false;
        emit(
          CollateralResultSuccess(
            CompleteType.SUCCESS,
            listCollateral: response,
          ),
        );
      },
      error: (error) {
        emit(
          CollateralResultSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }

  void funOnTapSearch() {
    textSearch.sink.add('');
  }
}
