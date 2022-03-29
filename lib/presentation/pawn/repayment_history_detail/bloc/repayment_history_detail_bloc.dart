import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/total_repaymnent_model.dart';
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';

import 'repayment_history_detail_state.dart';

class RepaymentHistoryDetailBloc
    extends BaseCubit<RepaymentHistoryDetailState> {
  final String id;

  RepaymentHistoryDetailBloc(this.id) : super(RepaymentHistoryDetailInitial()) {
    refreshPosts();
    getTotalRepayment();
  }

  static const int PROCESSING = 0;
  static const int WAIT_PAYMENT = 1;
  static const int COMPLETED = 3;
  static const int LATE = 2;
  static const int DEFAULT = 4;

  String mess = '';
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  // bool _isLoading = false;
  int page = 0;
  List<RepaymentRequestModel> list = [];

  bool get canLoadMore => canLoadMoreMy;

  BorrowRepository get _pawnService => Get.find();

  bool get isRefresh => _isRefresh;

  TotalRepaymentModel obj = TotalRepaymentModel.name();

  String getStatusHistory(int type) {
    switch (type) {
      case LATE:
        return S.current.late;
      case COMPLETED:
        return S.current.completed;
      case WAIT_PAYMENT:
        return S.current.wait_payment;
      case DEFAULT:
        return S.current.defaults;
      case PROCESSING:
        return S.current.processing;
      default:
        return '';
    }
  }

  Color getColorHistory(int type) {
    switch (type) {
      case LATE:
        return AppTheme.getInstance().redColor();
      case COMPLETED:
        return AppTheme.getInstance().blueColor();
      case WAIT_PAYMENT:
        return AppTheme.getInstance().orangeMarketColors();
      default:
        return AppTheme.getInstance().redColor();
    }
  }

  Future<void> refreshPosts() async {
    // if (!_isLoading) {
    //   page = 0;
    //   _isRefresh = true;
    //   _isLoading = true;
    //   await getListItemRepayment();
    // }
  }

  void loadMorePosts() {
    // if (!_isLoading) {
    //   page += 1;
    //   _isRefresh = false;
    //   _isLoading = true;
    //   getListItemRepayment();
    // }
  }

  Future<void> getListItemRepayment() async {
    showLoading();
    emit(RepaymentHistoryDetailLoading());
    final Result<List<RepaymentRequestModel>> response =
        await _pawnService.getListItemRepayment(
      id: id,
      // page: page.toString(),
      // size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        //_isLoading = false;
        emit(
          RepaymentHistoryDetailSuccess(
            CompleteType.SUCCESS,
            list: response,
          ),
        );
      },
      error: (error) {
        emit(
          RepaymentHistoryDetailSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
        //_isLoading = false;
      },
    );
  }

  Future<void> getTotalRepayment() async {
    final Result<TotalRepaymentModel> response =
        await _pawnService.getTotalRepayment(
      id: id,
    );
    response.when(
      success: (response) {
        obj = response;
      },
      error: (error) {},
    );
  }
}
