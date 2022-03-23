import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/history_detail_collateral_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';

import 'add_collateral_state.dart';

class AddCollateralBloc extends BaseCubit<AddCollateralState> {
  final String id;

  AddCollateralBloc(this.id) : super(AddCollateralInitial()) {
    refreshPosts();
  }

  String mess = '';
  String estimate = '';
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  List<HistoryCollateralModel> list = [];

  bool get canLoadMore => canLoadMoreMy;

  BorrowRepository get _pawnService => Get.find();

  bool get isRefresh => _isRefresh;

  //history
  static const int PENDING_HISTORY = 0;
  static const int SUCCESS_HISTORY = 1;
  static const int FAILED_HISTORY = 2;

  String getStatus(int type) {
    switch (type) {
      case PENDING_HISTORY:
        return S.current.pending;
      case SUCCESS_HISTORY:
        return S.current.success_pawn;
      case FAILED_HISTORY:
        return S.current.failed;
      default:
        return '';
    }
  }

  Color getColor(int type) {
    switch (type) {
      case PENDING_HISTORY:
        return AppTheme.getInstance().orangeMarketColors();
      case SUCCESS_HISTORY:
        return AppTheme.getInstance().greenMarketColors();
      case FAILED_HISTORY:
        return AppTheme.getInstance().redColor();
      default:
        return AppTheme.getInstance().redColor();
    }
  }

  Future<void> refreshPosts() async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getHistoryDetailCollateralMyAcc();
    }
  }

  void loadMorePosts() {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getHistoryDetailCollateralMyAcc();
    }
  }

  Future<void> getHistoryDetailCollateralMyAcc() async {
    showLoading();
    emit(AddCollateralLoading());
    final Result<List<HistoryCollateralModel>> response =
        await _pawnService.getHistoryDetailCollateralMyAcc(
      collateralId: id,
      page: page.toString(),
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
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
          AddCollateralSuccess(
            CompleteType.SUCCESS,
            list: response,
          ),
        );
      },
      error: (error) {
        emit(
          AddCollateralSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        _isLoading = false;
      },
    );
  }
}
