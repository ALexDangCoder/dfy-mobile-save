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
import 'package:rxdart/rxdart.dart';

part 'borrow_result_state.dart';

class BorrowResultCubit extends BaseCubit<BorrowResultState> {
  BorrowResultCubit() : super(BorrowResultInitial());

  BehaviorSubject<String> focusTextField =
  BehaviorSubject.seeded('');

  BorrowRepository get _repo => Get.find();

  String message = '';
   List<PawnshopPackage> pawnshopPackage = [];
   List<PersonalLending> personalLending = [];

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

  int page = 0;

  Future<void> refreshPosts() async {
    if (!loadMoreLoading) {
      showLoading();
      emit(BorrowResultLoading());
      page = 0;
      loadMoreRefresh = true;
      loadMoreLoading = true;
      callApi();
    }
  }

  Future<void> loadMorePosts() async {
    if (!loadMoreLoading) {
      emit(BorrowResultLoading());
      showLoading();
      page += 1;
      loadMoreRefresh = false;
      loadMoreLoading = true;
       await getPawnshopPackageResult();
    }
  }


  Future<void> getPersonLendingResult({
    String? collateralAmount,
    String? collateralSymbols,
    String? name,
    String? interestRanges,
    String? loanToValueRanges,
    String? loanSymbols,
    String? loanType,
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
      page: page.toString(),
    );
    result.when(
      success: (res) {
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
  }) async {
    final Result<List<PawnshopPackage>> result = await _repo.getListPawnshop(
      collateralAmount: collateralAmount,
      collateralSymbols: collateralSymbols,
      name: name,
      interestRanges: interestRanges,
      loanToValueRanges: loanToValueRanges,
      loanSymbols: loanSymbols,
      loanType: loanType,
      page: page.toString(),
    );
    result.when(
      success: (res) {
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
