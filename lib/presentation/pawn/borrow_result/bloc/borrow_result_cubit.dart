import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'borrow_result_state.dart';

class BorrowResultCubit extends BaseCubit<BorrowResultState> {
  BorrowResultCubit() : super(BorrowResultInitial());

  BorrowRepository get _repo => Get.find();

  void callApi({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
  }) {
    showLoading();
    getPawnshopPackageResult(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      loanType: loanType,
    );
    getPersonLendingResult(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      loanType: loanType,
    );
  }

  Future<void> getPersonLendingResult({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? page,
  }) async {
    final Result<List<PersonalLending>> result =
        await _repo.getListPersonalLending(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      loanType: loanType,
      page: '0',
    );
    result.when(
      success: (res) {
        showContent();
        emit(BorrowPersonSuccess(CompleteType.SUCCESS, personalLending: res));
      },
      error: (error) {
        emit(BorrowPersonSuccess(CompleteType.ERROR, message: error.message));
      },
    );
  }

  Future<void> getPawnshopPackageResult({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
    String? page,
  }) async {
    final Result<List<PawnshopPackage>> result = await _repo.getListPawnshop(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      loanType: loanType,
      page: '0',
    );
    result.when(
      success: (res) {
        showContent();
        emit(
          BorrowPawnshopSuccess(
            CompleteType.SUCCESS,
            pawnshopPackage: res,
          ),
        );
      },
      error: (error) {
        emit(BorrowPawnshopSuccess(CompleteType.ERROR, message: error.message));
      },
    );
  }
}
