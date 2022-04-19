import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/domain/repository/pawn/manage_loan_package/manage_loan_package_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

part 'loan_package_detail_state.dart';

class LoanPackageDetailCubit extends BaseCubit<LoanPackageDetailState> {
  LoanPackageDetailCubit() : super(LoanPackageDetailInitial());

  ManageLoanPackageRepository get _managePackageRepository => Get.find();

  PawnshopPackage pawnShopPackage = PawnshopPackage();
  List<CollateralResultModel> collateralsReceived = [];
  bool _flagApi = false;

  Future<void> getDetailPawnShopPackage(String packageId) async {
    showLoading();
    final Result<PawnshopPackage> result =
        await _managePackageRepository.getPawnshopDetail(packageId: packageId);
    result.when(
      success: (success) {
        _flagApi = true;
        pawnShopPackage = success;
      },
      error: (error) {
        _flagApi = false;
        pawnShopPackage = PawnshopPackage();
      },
    );
    await getCollateralPackageReceived(packageId);
  }

  int page = 0;
  int defaultSize = 5;

  Future<void> getCollateralPackageReceived(String id) async {
    final Result<List<CollateralResultModel>> result =
        await _managePackageRepository.getListCollateral(
      id: id,
      page: page.toString(),
      size: defaultSize.toString(),
    );
    result.when(
      success: (success) {
        emit(
          LoanPackageDetailLoadApi(
            CompleteType.SUCCESS,
            pawnShopPackage: pawnShopPackage,
            listCollateral: success,
          ),
        );
      },
      error: (error) {
        emit(
          LoanPackageDetailLoadApi(CompleteType.ERROR),
        );
      },
    );
  }

  static const int FAIL_CREATED = -1;
  static const int PROCESSING_OPEN = 0;
  static const int OPEN = 1;
  static const int PROCESSING_CANCEL = 2;
  static const int CANCELED = 3;
  static const Map<String, dynamic> AUTO = {'code': 0, 'name': 'Auto'};
  static const Map<String, dynamic> SEMI_AUTO = {
    'code': 1,
    'name': 'Semi-auto'
  };
  static const Map<String, dynamic> NEGOTIATION = {
    'code': 2,
    'name': 'Negotiation'
  };
  static const Map<String, dynamic> P2P_LENDER_PACKAGE = {
    'code': 3,
    'name': 'P2P'
  };

  String getStatusLoanPackage(int status) {
    switch (status) {
      case FAIL_CREATED:
        return 'Fail Created';
      case PROCESSING_OPEN:
        return 'Processing Open';
      case OPEN:
        return 'Open';
      case CANCELED:
        return 'Canceled';
      default:
        return 'Processing Cancel';
    }
  }

  Color getColorLoanPackage(int status) {
    switch (status) {
      case OPEN:
        return AppTheme.getInstance().blueMarketColors();
      case CANCELED:
        return AppTheme.getInstance().getPurpleColor();
      default:
        return orangeColor;
    }
  }

  String weekOrMonth({required int durationQtyType}) {
    if (durationQtyType == 0) {
      return 'weeks';
    } else {
      return 'months';
    }
  }

  String categoryOneOrMany({
    required int durationQty,
    required int durationType,
  }) {
    //0 is week
    //1 month
    if (durationType == 0) {
      if (durationQty > 1) {
        return '$durationQty ${S.current.week_many}';
      } else {
        return '$durationQty ${S.current.week_1}';
      }
    } else {
      if (durationQty > 1) {
        return '$durationQty ${S.current.month_many}';
      } else {
        return '$durationQty ${S.current.month_1}';
      }
    }
  }

  static const int COLLATERAL_PROCESSING_OPEN = 0;
  static const int COLLATERAL_OPEN = 1;
  static const int COLLATERAL_PROCESSING_ACCEPT = 2;
  static const int COLLATERAL_ACCEPTED = 3;
  static const int COLLATERAL_PROCESSING_REJECT = 4;
  static const int COLLATERAL_REJECTED = 5;
  static const int COLLATERAL_PROCESSING_WITHDRAW = 6;
  static const int COLLATERAL_WITHDRAW = 7;
  static const int COLLATERAL_PROCESSING_CONTRACTED = 8;
  static const int COLLATERAL_CONTRACTED = 9;

  Color getColorCollateral(int status) {
    switch (status) {
      case COLLATERAL_OPEN:
        return AppTheme.getInstance().blueMarketColors();
      case COLLATERAL_WITHDRAW:
      case COLLATERAL_REJECTED:
        return AppTheme.getInstance().redMarketColors();
      case COLLATERAL_ACCEPTED:
        return AppTheme.getInstance().successTransactionColors();
      default:
        return orangeMarketColor;
    }
  }

  String getStatusCollateral(int status) {
    switch (status) {
      case COLLATERAL_OPEN:
        return 'Open';
      case COLLATERAL_WITHDRAW:
        return 'WithDrawn';
      case COLLATERAL_REJECTED:
        return 'Rejected';
      case COLLATERAL_ACCEPTED:
        return 'Accepted';
      default:
        return 'Processing';
    }
  }

  bool flagCancelLoanPackage = false;

  Future<void> cancelLoanPackageAfterCFBC({required String id}) async {
    final result =
        await _managePackageRepository.postCancelLoanPackageAfterCFBC(id: id);
    result.when(
      success: (success) {
        flagCancelLoanPackage = true;
      },
      error: (error) {
        flagCancelLoanPackage = false;
      },
    );
  }
}
