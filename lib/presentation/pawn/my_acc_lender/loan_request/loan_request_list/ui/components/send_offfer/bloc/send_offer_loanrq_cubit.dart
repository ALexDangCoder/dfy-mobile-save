import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/token_inf.dart';
import 'package:Dfy/domain/repository/pawn/loan_request/loan_request_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

part 'send_offer_loanrq_state.dart';

class SendOfferLoanrqCubit extends Cubit<SendOfferLoanrqState> {
  LoanRequestRepository get _service => Get.find();

  SendOfferLoanrqCubit() : super(SendOfferLoanrqInitial());
  BehaviorSubject<String> textMess = BehaviorSubject.seeded('');
  BehaviorSubject<String> textAmount = BehaviorSubject.seeded('');
  BehaviorSubject<String> textLoan = BehaviorSubject.seeded('');
  BehaviorSubject<String> textLiquidationThreshold = BehaviorSubject.seeded('');
  BehaviorSubject<String> textDuration = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isMess = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isCheckBtn = BehaviorSubject.seeded(false);
  BehaviorSubject<String> isAmount = BehaviorSubject.seeded('');
  BehaviorSubject<String> isInterestRate = BehaviorSubject.seeded('');
  BehaviorSubject<bool> isBtn = BehaviorSubject.seeded(false);
  BehaviorSubject<String> textInterestRate = BehaviorSubject.seeded('');
  BehaviorSubject<String> textRecurringInterest =
      BehaviorSubject.seeded(S.current.weekly_pawn);
  BehaviorSubject<String> isLoan = BehaviorSubject.seeded('');
  BehaviorSubject<bool> chooseExisting = BehaviorSubject.seeded(false);
  BehaviorSubject<String> isDuration = BehaviorSubject.seeded('');
  BehaviorSubject<String> textToken = BehaviorSubject.seeded('DFY');
  BehaviorSubject<String> isLiquidationThreshold = BehaviorSubject.seeded('');
  BehaviorSubject<String> balanceWallet = BehaviorSubject.seeded('0');

  // final _web3utils = Web3Utils();
  String hexString = '';

  // Future<void> getCreateCryptoOfferDataHexString({
  //   required String repaymentAssetAddress,
  //   required String loanAmount,
  //   required String interest,
  //   required String duration,
  //   required String collateralId,
  //   required String liquidityThreshold,
  //   required int loanDurationType,
  //   required int repaymentCycleType,
  // }) async {
  //   hexString = await _web3utils.getCreateCryptoOfferData(
  //     collateralId: collateralId,
  //     liquidityThreshold: liquidityThreshold,
  //     repaymentAssetAddress: repaymentAssetAddress,
  //     loanAmount: loanAmount,
  //     interest: interest,
  //     duration: duration,
  //     loanDurationType: loanDurationType,
  //     repaymentCycleType: repaymentCycleType,
  //   );
  // }

  List<String> listToken = [];
  final regexAmount = RegExp(r'^\d+((.)|(.\d{0,5})?)$');
  final regexInterestRate = RegExp(r'^\d+((.)|(.\d{0,2})?)$');
  final regexInterest = RegExp(r'^\d+((.)|(.\d{0,2})?)$');
  final regexTime = RegExp(r'^\d+(()|(\d{})?)$');
  final Web3Utils web3Client = Web3Utils();

  Future<double> getBalanceToken({
    required String ofAddress,
    required String tokenAddress,
  }) async {
    late final double balance;
    try {
      balance = await web3Client.getBalanceOfToken(
        ofAddress: ofAddress,
        tokenAddress: tokenAddress,
      );
      balanceWallet.add(formatPrice.format(balance));
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
    return balance;
  }

  //recipe
  double collateralAmount = 0;

//LTV = (Loan USD Amount / Collateral USD Amount) x 100%
//
// Loan amount = amount of Collateral * LTV/100

  bool checkBtn() {
    if (textMess.value.isNotEmpty &&
        textLoan.value.isNotEmpty &&
        textAmount.value.isNotEmpty &&
        textLiquidationThreshold.value.isNotEmpty &&
        textInterestRate.value.isNotEmpty &&
        textDuration.value.isNotEmpty) {
      isBtn.add(true);
      return true;
    } else {
      isBtn.add(false);
      return false;
    }
  }

  // Future<void> postSendOfferRequest({
  //   String? loanToValue,
  //   String? liquidationThreshold,
  //   String? interestRate,
  //   String? loanAmount,
  //   String? latestBlockchainTxn,
  //   String? durationType,
  //   String? walletAddress,
  //   String? collateralId,
  //   String? loanRequestId,
  //   String? duration,
  //   String? message,
  //   String? repaymentToken,
  //   String? supplyCurrency,
  // }) async {
  //   final Result<SendOfferLendCryptoModel> result =
  //   await _repo.postSendOfferRequest(
  //     loanToValue: loanToValue,
  //     liquidationThreshold: liquidationThreshold,
  //     interestRate: interestRate,
  //     loanAmount: loanAmount,
  //     latestBlockchainTxn: latestBlockchainTxn,
  //     durationType: durationType,
  //     walletAddress: walletAddress,
  //     collateralId: collateralId,
  //     duration: duration,
  //     loanRequestId: loanRequestId,
  //     message: message,
  //     repaymentToken: repaymentToken,
  //     supplyCurrency: supplyCurrency,
  //   );
  //   result.when(
  //     success: (res) {},
  //     error: (error) {},
  //   );
  // }

  void enableButtonRequest(String value) {
    if (value.isNotEmpty) {
      if (regexTime.hasMatch(value)) {
        if (textRecurringInterest.value == S.current.weekly_pawn) {
          if (int.parse(value) > 5200) {
            textDuration.add('');
            isDuration.add(S.current.invalid_duration_week);
          } else {
            textDuration.add(value);
            isDuration.add('');
          }
        } else {
          if (int.parse(value) > 1200) {
            textDuration.add('');
            isDuration.add(S.current.invalid_duration_month);
          } else {
            textDuration.add(value);
            isDuration.add('');
          }
        }
      } else {
        textDuration.add('');
        isDuration.add(S.current.duration_is_integer);
      }
    } else {
      textDuration.add('');
      isDuration.add(S.current.invalid_duration);
    }
  }

  void getTokenInf() {
    final String list = PrefsService.getListTokenSupport();
    final List<TokenInf> listTokenInf = TokenInf.decode(list);
    for (final TokenInf value in listTokenInf) {
      listToken.add(value.symbol ?? '');
    }
  }

  void funCheckMess(String value) {
    if (value.isNotEmpty) {
      textMess.add(value);
      isMess.add(false);
    } else {
      textMess.add('');
      isMess.add(true);
    }
  }

  void funInterestRate(String value) {
    if (value.isNotEmpty) {
      if (!regexInterestRate.hasMatch(value)) {
        isInterestRate.add(
          '${S.current.must_below_2} ${S.current.or_pawn} '
          '${S.current.invalid_interest_rate}',
        );
        textInterestRate.add('');
      } else {
        textInterestRate.add(value);
        isInterestRate.add('');
      }
    } else {
      textInterestRate.add('');
      isInterestRate.add(S.current.interest_rate_is_required);
    }
  }

  bool funValidateAmount(String value) {
    if (value.isNotEmpty) {
      if (!regexAmount.hasMatch(value)) {
        isAmount.add(S.current.invalid_amount);
        textAmount.add('');
        return false;
      } else {
        isAmount.add('');
        textAmount.add(value);
        return true;
      }
    } else {
      textAmount.add('');
      isAmount.add(S.current.amount_required);
      return false;
    }
  }

  bool funValidateLoan(String value) {
    funValidateLiquidationThreshold(textLiquidationThreshold.value);
    if (value.isNotEmpty) {
      if (!regexAmount.hasMatch(value)) {
        textLoan.add('');
        isLoan.add(S.current.invalid_loan_to_value);
        return false;
      } else {
        textLoan.add(value);
        isLoan.add('');
        return true;
      }
    } else {
      textLoan.add('');
      isLoan.add(S.current.loan_to_value_is_required);
      return false;
    }
  }

  void funValidateLiquidationThreshold(String value) {
    if (value.isNotEmpty) {
      if (!regexAmount.hasMatch(value)) {
        isLiquidationThreshold.add(S.current.invalid_liquid_threshold);
        textLiquidationThreshold.add('');
      } else {
        double loanToValue = 0;
        if (textLoan.value.isNotEmpty) {
          loanToValue = double.parse(textLoan.value);
          if (double.parse(value) < loanToValue) {
            isLiquidationThreshold.add(S.current.ltv_validate);
            textLiquidationThreshold.add('');
          } else if (double.parse(value) < loanToValue + 20) {
            isLiquidationThreshold.add(S.current.ltv_validate_20);
            textLiquidationThreshold.add('');
          } else {
            textLiquidationThreshold.add(value);
            isLiquidationThreshold.add('');
          }
        } else {
          textLiquidationThreshold.add(value);
          isLiquidationThreshold.add('');
        }
      }
    } else {
      textLiquidationThreshold.add('');
      isLiquidationThreshold.add(S.current.liquid_threshold_is_required);
    }
  }

  Future<void> postSendOfferCryptoToBe({
    required String loanRequestId,
    required String duration,
    required String supplyCurrency,
    required String interestRate,
    required String loanAmount,
    required String id,
    required String latestBlockchainTxn,
    required String message,
    required String collateralId,
    required String durationType,
    required String loanToValue,
    required String liquidationThreshold,
    required String repaymentToken,
  }) async {
    final result = await _service.postSendOfferCryptoToBe(
      loanRequestId: loanRequestId,
      duration: duration,
      supplyCurrency: supplyCurrency,
      interestRate: interestRate,
      loanAmount: loanAmount,
      latestBlockchainTxn: latestBlockchainTxn,
      message: message,
      collateralId: collateralId,
      durationType: durationType,
      walletAddress: PrefsService.getCurrentBEWallet(),
      loanToValue: loanToValue,
      liquidationThreshold: liquidationThreshold,
      repaymentToken: repaymentToken,
      id: id,
    );
    result.when(success: (success) {}, error: (error) {});
  }

  Future<void> rejectOfferCryptoLoanRequest({required String id}) async {
    final result =
        await _service.postRejectCryptoLoanRequest(loanRequestId: id);
    result.when(success: (success) {}, error: (error) {});
  }
}
