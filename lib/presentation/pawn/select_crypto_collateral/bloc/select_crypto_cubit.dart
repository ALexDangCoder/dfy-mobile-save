import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'select_crypto_state.dart';

class SelectCryptoCubit extends BaseCubit<SelectCryptoState> {
  SelectCryptoCubit() : super(SelectCryptoInitial());

  List<CryptoCollateralModel> listCryptoCollateral = [];

  String message = '';

  int page = 0;

  BorrowRepository get _repo => Get.find();

  bool loadMore = false;
  bool canLoadMoreList = true;
  bool refresh = false;

  Future<void> refreshPosts(
    String walletAddress,
    String packageId,
    bool isLoanRequest,
  ) async {
    if (!refresh) {
      showLoading();
      emit(SelectCryptoLoading());
      page = 0;
      canLoadMoreList = true;
      refresh = true;
      await getCryptoCollateral(
        walletAddress,
        packageId,
        isLoanRequest,
      );
    }
  }

  Future<void> loadMorePosts(
    String walletAddress,
    String packageId,
    bool isLoanRequest,
  ) async {
    if (!loadMore) {
      showLoading();
      page += 1;
      canLoadMoreList = false;
      loadMore = true;
      await getCryptoCollateral(
        walletAddress,
        packageId,
        isLoanRequest,
      );
    }
  }

  Future<void> getCryptoCollateral(
    String walletAddress,
    String packageId,
    bool isLoanRequest,
  ) async {
    final Result<List<CryptoCollateralModel>> result =
        await _repo.getListCryptoCollateral(
      walletAddress,
      packageId,
      page.toString(),
      isLoanRequest,
    );
    result.when(
      success: (res) {
        emit(
          GetApiSuccess(
            CompleteType.SUCCESS,
            list: res,
          ),
        );
      },
      error: (error) {
        emit(
          GetApiSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }
}
