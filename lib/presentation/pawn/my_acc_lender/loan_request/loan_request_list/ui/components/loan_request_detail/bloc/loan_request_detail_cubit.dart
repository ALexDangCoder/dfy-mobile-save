import 'dart:ui';

import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/pawn/loan_request_list/detail_loan_request_crypto_model.dart';
import 'package:Dfy/domain/model/pawn/reputation_borrower.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/pawn/loan_request/loan_request_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

part 'loan_request_detail_state.dart';

class LoanRequestDetailCubit extends BaseCubit<LoanRequestDetailState> {
  LoanRequestDetailCubit() : super(LoanRequestDetailInitial());

  LoanRequestRepository get _service => Get.find();

  ///API DETAIL CRYPTO
  List<ReputationBorrower> reputationBorrower = [];
  DetailLoanRequestCryptoModel detailLoanRequestCryptoModel =
      DetailLoanRequestCryptoModel();

  bool _flagApi = false;

  Future<void> callAllApi({
    required String walletAddress,
    required String id,
  }) async {
    showLoading();
    await getDetailCrypto(id);
    await getReputationBorrower(walletAddress);
    if (_flagApi) {
      emit(
        LoanRequestDetailLoadApi(
          CompleteType.SUCCESS,
        ),
      );
      showContent();
    } else {
      emit(
        LoanRequestDetailLoadApi(
          CompleteType.ERROR,
        ),
      );
      showError();
    }
  }

  Future<void> getReputationBorrower(String walletAddress) async {
    final Result<List<ReputationBorrower>> result =
        await _service.getBorrowerInfo(walletAddress);
    result.when(
      success: (success) {
        _flagApi = true;
        reputationBorrower = success;
      },
      error: (error) {
        _flagApi = false;
      },
    );
  }

  Future<void> getDetailCrypto(String id) async {
    showLoading();
    final Result<DetailLoanRequestCryptoModel> result =
        await _service.getDetailLoanRequest(id);
    result.when(
      success: (response) {
        _flagApi = true;
        detailLoanRequestCryptoModel = response;
      },
      error: (error) {
        _flagApi = false;
        emit(
          LoanRequestDetailLoadApi(
            CompleteType.ERROR,
          ),
        );
      },
    );
  }

  static const int PROCESSING_OPEN = 0;
  static const int OPEN = 1;
  static const int PROCESSING_ACCEPT = 2;
  static const int ACCEPT = 3;
  static const int PROCESSING_REJECT = 4;
  static const int REJECT = 5;
  static const int PROCESSING_WITHDRAW = 6;
  static const int CANCEL = 7;
  static const int PROCESSING_CONTRACTED = 8;
  static const int CONTRACTED = 9;
  static const int END_CONTRACT = 10;

  String getStatus(int type) {
    switch (type) {
      case OPEN:
        return S.current.open;
      case ACCEPT:
        return S.current.accepted;
      case REJECT:
        return S.current.rejected;
      case CANCEL:
        return S.current.canceled;
      default:
        return '';
    }
  }

  Color getColor(int type) {
    switch (type) {
      case OPEN:
        return AppTheme.getInstance().blueColor();
      case ACCEPT:
        return AppTheme.getInstance().successTransactionColors();
      case REJECT:
        return AppTheme.getInstance().redMarketColors();
      case CANCEL:
        return AppTheme.getInstance().failTransactionColors();
      default:
        return orangeColor;
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

  List<TokenInf> listTokenSupport = [];

  ///GET EXCHANGE USD TOKEN
  void getTokenInf() {
    final String listToken = PrefsService.getListTokenSupport();
    listTokenSupport = TokenInf.decode(listToken);
  }

  double getExchangeUSD({required String symbolToken}) {
    return listTokenSupport
            .where((element) => (element.symbol ?? '') == symbolToken)
            .first
            .usdExchange ??
        0;
  }

  Future<void> rejectOfferCryptoLoanRequest({required String id}) async {
    final result =
    await _service.postRejectCryptoLoanRequest(loanRequestId: id);
    result.when(success: (success) {}, error: (error) {});
  }
}
