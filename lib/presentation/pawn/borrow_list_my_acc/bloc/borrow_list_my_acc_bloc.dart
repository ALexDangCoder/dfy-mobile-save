import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/crypto_pawn_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/api_constants.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'borrow_list_my_acc_state.dart';

class BorrowListMyAccBloc extends BaseCubit<BorrowListMyAccState> {
  BorrowListMyAccBloc() : super(BorrowListMyAccInitial());

  BorrowRepository get _pawnService => Get.find();
  static const String BORROW_TYPE = '0';
  static const String NFT_TYPE = '1';

  String mess = '';
  String estimate = '';
  bool canLoadMoreMy = true;
  bool _isRefresh = true;
  bool _isLoading = false;
  int page = 0;
  List<CryptoPawnModel> list = [];
  List<CryptoPawnModel> listNFT = [];

  bool get canLoadMore => canLoadMoreMy;

  bool get isRefresh => _isRefresh;

  //history
  static const int ACTIVE = 1;
  static const int COMPLETED = 2;
  static const int DEFAULT = 3;

  String getStatus(int type) {
    switch (type) {
      case ACTIVE:
        return S.current.active;
      case COMPLETED:
        return S.current.completed;
      case DEFAULT:
        return S.current.defaults;
      default:
        return '';
    }
  }

  Color getColor(int type) {
    switch (type) {
      case ACTIVE:
        return AppTheme.getInstance().greenMarketColors();
      case COMPLETED:
        return AppTheme.getInstance().blueMarketColors();
      case DEFAULT:
        return AppTheme.getInstance().redColor();
      default:
        return AppTheme.getInstance().redColor();
    }
  }

  Future<void> refreshPosts({
    required String type,
  }) async {
    if (!_isLoading) {
      page = 0;
      _isRefresh = true;
      _isLoading = true;
      await getBorrowContract(
        type: type,
      );
    }
  }

  void loadMorePosts({
    required String type,
  }) {
    if (!_isLoading) {
      page += 1;
      _isRefresh = false;
      _isLoading = true;
      getBorrowContract(
        type: type,
      );
    }
  }

  Future<void> getBorrowContract({
    String? type,
    String? borrowerWalletAddress,
  }) async {
    showLoading();
    if (type == NFT_TYPE) {
      emit(BorrowListMyAccLoading());
    } else {
      emit(BorrowListMyAccNFTLoading());
    }
    final Result<List<CryptoPawnModel>> response =
        await _pawnService.getBorrowContract(
      size: ApiConstants.DEFAULT_PAGE_SIZE.toString(),
      page: page.toString(),
      type: type,
      borrowerWalletAddress: '0xa2E3Db206948b93201a8c732bdA8385B77D48002',
      status: '',
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          canLoadMoreMy = true;
        } else {
          canLoadMoreMy = false;
        }
        _isLoading = false;
        if (type == NFT_TYPE) {
          emit(
            BorrowListMyAccNFTSuccess(
              CompleteType.SUCCESS,
              listNFT: response,
            ),
          );
        } else {
          emit(
            BorrowListMyAccSuccess(
              CompleteType.SUCCESS,
              list: response,
            ),
          );
        }
      },
      error: (error) {
        if (type == NFT_TYPE) {
          emit(
            BorrowListMyAccNFTSuccess(
              CompleteType.ERROR,
              message: error.message,
            ),
          );
        } else {
          emit(
            BorrowListMyAccSuccess(
              CompleteType.ERROR,
              message: error.message,
            ),
          );
        }
        _isLoading = false;
      },
    );
  }
}
