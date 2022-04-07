import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/home_pawn/check_rate_model.dart';
import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/domain/model/pawn/repayment_stats_model.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/contract_detail/ui/contract_detail.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import 'contract_detail_state.dart';

class ContractDetailBloc extends BaseCubit<ContractDetailState> {
  final int id;
  final TypeBorrow typeBorrow;
  final TypeNavigator typeNavigator;
  late String typePawn;
  int page = 0;
  bool? isShow;
  bool? isRate;
  bool isCanLoadMore = true;
  List<RepaymentRequestModel> listRequestMy = [];
  BehaviorSubject<List<RepaymentRequestModel>> listRequest =
      BehaviorSubject.seeded([]);
  RepaymentStatsModel? objRepayment;
  ContractDetailPawn? objDetail;
  BehaviorSubject<String> rate = BehaviorSubject.seeded('0');
  BehaviorSubject<String> rateMy = BehaviorSubject.seeded('0');

  ContractDetailBloc(this.id, this.typeBorrow, this.typeNavigator)
      : super(ContractDetailInitial()) {
    getData();
  }

  static const int ACTIVE = 1;
  static const int COMPLETED = 2;
  static const int DEFAULT = 3;

  static const int PROCESSING = 0;
  static const int WAIT_PAYMENT = 1;
  static const int COMPLETED_HISTORY = 3;
  static const int LATE = 2;
  static const int DEFAULT_HISTORY = 4;

  static const int LATE_TEXT = 0;
  static const int RICK = 1;
  static const int UNPAID = 2;

  String getStatusDefault({
    int max = 0,
    required int status,
  }) {
    switch (status) {
      case LATE_TEXT:
        return S.current.maximum_late_payment +
            max.toString() +
            S.current.times;
      case RICK:
        return S.current.ltv_liquidation_threshold;
      case UNPAID:
        return S.current.loan_repayment;
      default:
        return '';
    }
  }

  String getStatusHistory(int type) {
    switch (type) {
      case LATE:
        return S.current.late;
      case COMPLETED_HISTORY:
        return S.current.completed;
      case WAIT_PAYMENT:
        return S.current.wait_payment;
      case DEFAULT_HISTORY:
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
      case COMPLETED_HISTORY:
        return AppTheme.getInstance().blueColor();
      case WAIT_PAYMENT:
        return AppTheme.getInstance().orangeMarketColors();
      default:
        return AppTheme.getInstance().redColor();
    }
  }

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

  BorrowRepository get _pawnService => Get.find();

  Future<void> getReputation(String addressWallet, {int rateType = 0}) async {
    final Result<List<ReputationBorrower>> response =
        await _pawnService.getListReputation(
      addressWallet: addressWallet,
    );
    response.when(
      success: (response) {
        if (response.isNotEmpty) {
          if (rateType == 0) {
            rate.add(response.first.reputationLender.toString());
          } else {
            rateMy.add(response.first.reputationBorrower.toString());
          }
        }
      },
      error: (error) {},
    );
  }

  void getData() {
    if (typeBorrow == TypeBorrow.CRYPTO_TYPE) {
      typePawn = '0';
    } else {
      typePawn = '1';
    }
    getCheckRate();
    getRepaymentRequest();
    getRepaymentHistory();
    getLenderContract();
  }

  Future<void> getLenderContract() async {
    showLoading();
    String typePawn = '0';
    if (typeBorrow == TypeBorrow.CRYPTO_TYPE) {
      typePawn = '0';
    } else {
      typePawn = '1';
    }
    late final Result<ContractDetailPawn> response;
    if (typeNavigator == TypeNavigator.BORROW_TYPE) {
      response = await _pawnService.getLenderContract(
        type: typePawn,
        id: id.toString(),
        walletAddress: PrefsService.getCurrentWalletCore(),
      );
    } else {
      response = await _pawnService.getLenderDetail(
        type: typePawn,
        id: id.toString(),
        walletAddress: PrefsService.getCurrentWalletCore(),
      );
    }
    response.when(
      success: (response) {
        getReputation(response.lenderWalletAddress.toString());
        getReputation(
          response.borrowerWalletAddress.toString(),
          rateType: 1,
        );
        emit(
          ContractDetailSuccess(
            CompleteType.SUCCESS,
            obj: response,
          ),
        );
      },
      error: (error) {
        emit(
          ContractDetailSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }

  Future<void> getCheckRate() async {
    final Result<CheckRateModel> response = await _pawnService.getCheckRate(
      contractId: id.toString(),
      type: typePawn,
      walletAddress: PrefsService.getCurrentWalletCore(),
    );
    response.when(
      success: (response) {
        isRate = response.isReview;
        isShow = response.isShow;
      },
      error: (error) {},
    );
  }

  Future<void> getRepaymentHistory() async {
    final Result<RepaymentStatsModel> response =
        await _pawnService.getRepaymentHistory(
      id: id.toString(),
    );
    response.when(
      success: (response) {
        objRepayment = response;
      },
      error: (error) {},
    );
  }

  Future<void> getRepaymentRequest() async {
    showLoading();
    final Result<List<RepaymentRequestModel>> response =
        await _pawnService.getRepaymentResquest(
      id: id.toString(),
      size: '3',
      page: page.toString(),
    );
    response.when(
      success: (response) {
        page++;
        if (response.length == 3) {
          isCanLoadMore = true;
        } else {
          isCanLoadMore = false;
        }
        showContent();
        listRequestMy.addAll(response);
        listRequest.add(listRequestMy);
      },
      error: (error) {},
    );
  }
}
