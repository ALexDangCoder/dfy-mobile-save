import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
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
  static const int AUTO_SEND_TO = 0;
  static const int SEMI_AUTO_SEND_TO = 1;
  static const int NEGOTIATION_SEND_TO = 2;
  static const int P2P_LENDER_PACKAGE_SEND_TO = 3;
  static const int CANCEL_PACKAGE_SEND_TO = 3;

  //offer
  static const int ACCEPT_OFFER = 7;
  static const int REJECT_OFFER = 8;
  static const int CANCEL_OFFER = 9;
  static const int OPEN_OFFER = 3;

  BehaviorSubject<bool> isAddSend = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAdd = BehaviorSubject.seeded(false);
  List<OffersReceivedModel> listOffersReceived = [];
  List<HistoryCollateralModel> listHistoryCollateral = [];
  List<SendToLoanPackageModel> listSendToLoanPackageModel = [];
  String hexString = '';

  BorrowRepository get _pawnService => Get.find();
  final Web3Utils web3Client = Web3Utils();

  Future<void> getWithdrawCryptoCollateralData({
    required String wad,
  }) async {
    try {
      hexString = await web3Client.getWithdrawCryptoCollateralData(
        wad: wad,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
  }

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
        getListReceived(collateralId: collateralId); //521
        getListSendToLoanPackage(collateralId: collateralId); //525
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

  bool checkBtn(int status) {
    switch (status) {
      case OPEN:
        return true;
      default:
        return false;
    }
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
        return S.current.withdraw_status;
      case FAILED:
        return S.current.failed;
      default:
        return '';
    }
  }

  String getStatusPackageSendTo(int type) {
    switch (type) {
      case AUTO_SEND_TO:
        return S.current.auto;
      case SEMI_AUTO_SEND_TO:
        return S.current.semi_auto;
      case NEGOTIATION_SEND_TO:
        return S.current.negotiation;
      case P2P_LENDER_PACKAGE_SEND_TO:
        return S.current.p2p_lender;
      default:
        return '';
    }
  }

  bool checkPackage(int status) {
    switch (status) {
      case CANCEL_PACKAGE_SEND_TO:
        return false;
      default:
        return true;
    }
  }

  Color getColorPackageSendTo(int type) {
    switch (type) {
      case AUTO_SEND_TO:
        return AppTheme.getInstance().blueMarketColors();
      case SEMI_AUTO_SEND_TO:
        return AppTheme.getInstance().orangeMarketColors();
      case NEGOTIATION_SEND_TO:
        return AppTheme.getInstance().greenMarketColors();
      case P2P_LENDER_PACKAGE_SEND_TO:
        return AppTheme.getInstance().redColor();
      default:
        return AppTheme.getInstance().redColor();
    }
  }

  String getStatusOffer(int status) {
    switch (status) {
      case ACCEPT_OFFER:
        return S.current.accepted;
      case REJECT_OFFER:
        return S.current.reject_ed;
      case CANCEL_OFFER:
        return S.current.canceled;
      case OPEN_OFFER:
        return S.current.open;
      default:
        return S.current.pending;
    }
  }

  Color getColorOffer(int status) {
    switch (status) {
      case ACCEPT_OFFER:
        return AppTheme.getInstance().yellowColor();
      case REJECT_OFFER:
        return AppTheme.getInstance().redColor();
      case CANCEL_OFFER:
        return AppTheme.getInstance().redColor();
      case OPEN_OFFER:
        return AppTheme.getInstance().greenMarketColors();
      default:
        return AppTheme.getInstance().orangeMarketColors();
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

  Future<void> getListReceived({
    String? collateralId,
    String? page,
    String? size,
  }) async {
    final Result<List<OffersReceivedModel>> response =
        await _pawnService.getListReceived(
      collateralId: collateralId,
    );
    response.when(
      success: (response) {
        listOffersReceived.clear();
        listOffersReceived.addAll(response);
        isAdd.add(isAdd.value);
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
      collateralId: collateralId,
    );
    response.when(
      success: (response) {
        listSendToLoanPackageModel.clear();
        listSendToLoanPackageModel.addAll(response);
        isAddSend.add(isAddSend.value);
      },
      error: (error) {},
    );
  }

  Future<void> postCollateralWithdraw({
    String? id,
  }) async {
    final Result<String> response = await _pawnService.postCollateralWithdraw(
      id: id.toString(),
    );
    response.when(
      success: (response) {},
      error: (error) {},
    );
  }
}
