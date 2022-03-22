import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/model/home_pawn/collateral_detail_my_acc_model.dart';
import 'package:Dfy/domain/model/home_pawn/history_detail_collateral_model.dart';
import 'package:Dfy/domain/model/home_pawn/offers_received_model.dart';
import 'package:Dfy/domain/model/home_pawn/send_to_loan_package_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/collateral_detail_my_acc/bloc/collateral_detail_my_acc_state.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class CollateralDetailMyAccBloc extends BaseCubit<CollateralDetailMyAccState> {
  CollateralDetailMyAccBloc() : super(CollateralDetailMyAccInitial());

  //detail
  static const int PROCESSING_CREATE = 1;
  static const int FAIL_CREATE = 2;
  static const int OPEN = 3;
  static const int PROCESSING_ACCEPT = 4;
  static const int PROCESSING_WITHDRAW = 5;
  static const int ACCEPTED = 6;
  static const int WITHDRAW = 7;
  static const int FAILED = 8;

  //to loan_SEND_TO
  static const int FAIL_CREATE_TO_SEND_TO = -1;
  static const int PROCESSING_OPEN_SEND_TO = 0;
  static const int OPEN_SEND_TO = 1;
  static const int PROCESSING_CANCEL_SEND_TO = 2;
  static const int CANCELLED_SEND_TO = 3;

  //history
  static const int PENDING_HISTORY = 0;
  static const int SUCCESS_HISTORY = 1;
  static const int FAILED_HISTORY = 2;

  //offer
  static const int WAITING_OFFER = 0;
  static const int ACCEPT_OFFER = 1;
  static const int REJECT_OFFER = 2;
  static const int CANCEL_OFFER = 3;

  BehaviorSubject<bool> isAddSend = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAdd = BehaviorSubject.seeded(false);
  List<OffersReceivedModel> listOffersReceived = [];
  List<HistoryCollateralModel> listHistoryCollateral = [];
  List<SendToLoanPackageModel> listSendToLoanPackageModel = [];

  BorrowRepository get _pawnService => Get.find();

  Future<void> getDetailCollateralMyAcc({
    String? collateralId,
  }) async {
    showLoading();
    final Result<CollateralDetailMyAcc> response =
        await _pawnService.getDetailCollateralMyAcc(
      collateralId: collateralId,
    );
    response.when(
      success: (response) {
        emit(
          CollateralDetailMyAccSuccess(
            CompleteType.SUCCESS,
            obj: response,
          ),
        );
        getListReceived(collateralId: 521.toString()); //521
        getListSendToLoanPackage(collateralId: 525.toString()); //525
        getHistoryDetailCollateralMyAcc(collateralId: collateralId);
      },
      error: (error) {
        emit(
          CollateralDetailMyAccSuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }

  String getStatus(int status) {
    switch (status) {
      case PROCESSING_CREATE:
        return S.current.processing_create;
      case FAIL_CREATE:
        return S.current.failed_create;
      case OPEN:
        return S.current.open;
      case PROCESSING_ACCEPT:
        return S.current.processing_accept;
      case PROCESSING_WITHDRAW:
        return S.current.processing_withdraw;
      case ACCEPTED:
        return S.current.accepted;
      case WITHDRAW:
        return S.current.withdraw;
      case FAILED:
        return S.current.failed;
      default:
        return '';
    }
  }

  Color getColor(int status) {
    switch (status) {
      case PROCESSING_CREATE:
        return AppTheme.getInstance().orangeMarketColors();
      case FAIL_CREATE:
        return AppTheme.getInstance().redColor();
      case OPEN:
        return AppTheme.getInstance().blueColor();
      case PROCESSING_ACCEPT:
        return AppTheme.getInstance().orangeMarketColors();
      case PROCESSING_WITHDRAW:
        return AppTheme.getInstance().orangeMarketColors();
      case ACCEPTED:
        return AppTheme.getInstance().greenMarketColors();
      case WITHDRAW:
        return AppTheme.getInstance().redColor();
      case FAILED:
        return AppTheme.getInstance().redColor();
      default:
        return AppTheme.getInstance().redColor();
    }
  }

  Future<void> getHistoryDetailCollateralMyAcc({
    String? collateralId,
    String? page,
    String? size,
  }) async {
    final Result<List<HistoryCollateralModel>> response =
        await _pawnService.getHistoryDetailCollateralMyAcc(
      collateralId: collateralId,
      page: '0', //todo
      size: '12',
    );
    response.when(
      success: (response) {
        listHistoryCollateral.addAll(response);
      },
      error: (error) {},
    );
  }

  Future<void> getListReceived({
    String? collateralId,
    String? page,
    String? size,
  }) async {
    final Result<List<OffersReceivedModel>> response =
        await _pawnService.getListReceived(
      collateralId: collateralId, //todo
    );
    response.when(
      success: (response) {
        listOffersReceived.addAll(response);
      },
      error: (error) {},
    );
  }

  Future<void> getListSendToLoanPackage({
    String? collateralId,
    String? page,
    String? size,
  }) async {
    final Result<List<SendToLoanPackageModel>> response =
        await _pawnService.getListSendToLoanPackage(
      collateralId: collateralId, //todo
    );
    response.when(
      success: (response) {
        listSendToLoanPackageModel.addAll(response);
      },
      error: (error) {},
    );
  }
}
