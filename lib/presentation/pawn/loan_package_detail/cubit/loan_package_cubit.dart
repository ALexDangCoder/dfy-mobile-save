import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

part 'loan_package_state.dart';

class LoanPackageCubit extends BaseCubit<LoanPackageState> {
  LoanPackageCubit() : super(LoanPackageInitial());

  PawnshopPackage pawnshopPackage = PawnshopPackage();
  String message = '';

  BorrowRepository get _repo => Get.find();

  Future<void> getBalanceOFToken(PawnshopPackage pawnshopPackage) async {
    if (pawnshopPackage.loanToken?[0].symbol != 'BNB') {
      pawnshopPackage.available = await Web3Utils().getBalanceOfToken(
        ofAddress: pawnshopPackage.pawnshop?.walletAddress ?? '',
        tokenAddress: pawnshopPackage.loanToken?[0].address ?? '',
      );
    } else {
      pawnshopPackage.available = await Web3Utils().getBalanceOfBnb(
        ofAddress: pawnshopPackage.pawnshop?.walletAddress ?? '',
      );
    }
  }

  Future<void> getDetailPawnshop(String packageId) async {
    showLoading();
    final Result<PawnshopPackage> result =
        await _repo.getPawnshopDetail(packageId: packageId);
    result.when(
      success: (res) {
        getBalanceOFToken(res);
        emit(LoanPackageSuccess(CompleteType.SUCCESS,pawnshopPackage: res,));
      },
      error: (error) {
        emit(LoanPackageSuccess(CompleteType.SUCCESS,message: error.message,));
      },
    );
  }
}
