import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/pawn/calculate_repayment_fee.dart';
import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/domain/repository/home_pawn/borrow_repository.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/repayment/bloc/repayment_pay_state.dart';
import 'package:Dfy/presentation/pawn/repayment/ui/repayment_pay.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class RepaymentPayBloc extends BaseCubit<RepaymentPayState> {
  RepaymentPayBloc() : super(RepaymentPayInitial());
  RepaymentRequestModel obj = RepaymentRequestModel.name();
  TypeRepayment type = TypeRepayment.PENALTY_INTEREST;
  BehaviorSubject<String> penalty = BehaviorSubject.seeded('');
  BehaviorSubject<String> interest = BehaviorSubject.seeded('');
  BehaviorSubject<String> loan = BehaviorSubject.seeded('');

  BehaviorSubject<bool> isBtn = BehaviorSubject.seeded(false);
  BehaviorSubject<String> isPenalty = BehaviorSubject.seeded('');
  BehaviorSubject<String> isInterest = BehaviorSubject.seeded('');
  BehaviorSubject<String> isLoan = BehaviorSubject.seeded('');
  String? hexString;
  String checkPostRepay = '';

  BorrowRepository get _pawnService => Get.find();
  final Web3Utils web3Client = Web3Utils();
  double balancePenalty = 0;
  double balanceInterest = 0;
  double balanceLoan = 0;
  double? maxInterest;
  double? maxLoan;
  double? maxPenalty;

  String id = '';
  bool isChoose = true;
  RepaymentRequestModel objRepayment = RepaymentRequestModel.name();

  void validatePenalty(String value) {
    if (value.isNotEmpty) {
      if (double.parse(value) > balancePenalty) {
        isPenalty.add(S.current.invalid_amount);
        penalty.add('');
      } else if (double.parse(value) > (maxPenalty ?? 0)) {
        isPenalty.add(S.current.invalid_amount);
        penalty.add('');
      } else {
        penalty.add(value);
        isPenalty.add('');
      }
    } else {
      penalty.add('');
      isPenalty.add(S.current.value_is_required);
    }
    checkBtn();
  }

  void validateLoan(String value) {
    if (value.isNotEmpty) {
      if (double.parse(value) > balanceLoan) {
        isLoan.add(S.current.invalid_amount);
        loan.add('');
      } else if (double.parse(value) > (maxLoan ?? 0)) {
        isLoan.add(S.current.invalid_amount);
        loan.add('');
      } else {
        isLoan.add('');
        loan.add(value);
      }
    } else {
      loan.add('');
      isLoan.add(S.current.value_is_required);
    }
    checkBtn();
  }

  void validateInterest(String value) {
    if (value.isNotEmpty) {
      if (double.parse(value) > balanceInterest) {
        interest.add('');
        isInterest.add(S.current.invalid_amount);
      } else if (double.parse(value) > (maxInterest ?? 0)) {
        isInterest.add(S.current.invalid_amount);
        interest.add('');
      } else {
        isInterest.add('');
        interest.add(value);
      }
    } else {
      interest.add('');
      isInterest.add(S.current.value_is_required);
    }
    checkBtn();
  }

  void checkBtn() {
    if (isChoose) {
      if (interest.value.isNotEmpty &&
          penalty.value.isNotEmpty &&
          loan.value.isNotEmpty) {
        isBtn.add(true);
      } else {
        isBtn.add(false);
      }
    } else {
      if (type == TypeRepayment.LOAN) {
        if (loan.value.isNotEmpty) {
          isBtn.add(true);
        } else {
          isBtn.add(false);
        }
      } else {
        if (interest.value.isNotEmpty && penalty.value.isNotEmpty) {
          isBtn.add(true);
        } else {
          isBtn.add(false);
        }
      }
    }
  }

  Future<void> getRepaymentDataNFT({
    required String paidInterestAmount,
    required String paidLoanAmount,
    required String paidPenaltyAmount,
    required String id,
  }) async {
    try {
      showLoading();
      hexString = await web3Client.getRepaymentNftData(
        paidPenaltyAmount: paidPenaltyAmount,
        paidLoanAmount: paidLoanAmount,
        contractId: id,
        paidInterestAmount: paidInterestAmount,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
  }

  Future<void> getRepaymentData({
    required String paidInterestAmount,
    required String paidLoanAmount,
    required String paidPenaltyAmount,
    required String uid,
    required String bcContractId,
  }) async {
    try {
      showLoading();
      hexString = await web3Client.getRepaymentData(
        paidInterestAmount: paidInterestAmount,
        paidLoanAmount: paidLoanAmount,
        paidPenaltyAmount: paidPenaltyAmount,
        uid: uid,
        contractId: bcContractId,
      );
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
  }

  Future<void> getBalanceToken({
    required String ofAddress,
    required String tokenAddress,
    required int type,
  }) async {
    late final double balance;
    try {
      balance = await web3Client.getBalanceOfToken(
        ofAddress: ofAddress,
        tokenAddress: tokenAddress,
      );
      if (type == 0) {
        balancePenalty = balance;
      } else if (type == 1) {
        balanceInterest = balance;
      } else {
        balanceLoan = balance;
      }
    } catch (e) {
      throw AppException(S.current.error, e.toString());
    }
  }

  Future<void> postRepaymentPay() async {
    showLoading();
    final Result<dynamic> response = await _pawnService.postRepaymentPay(
      id: id,
      repaymentPayRequest: CalculateRepaymentRequest(
        interest: AmountRequest(
          amount: double.tryParse(
            interest.value.isNotEmpty ? interest.value : '0',
          ),
          address: obj.interest?.address.toString(),
          symbol: obj.interest?.symbol.toString(),
        ),
        loan: AmountRequest(
          amount: double.tryParse(
            loan.value.isNotEmpty ? loan.value : '0',
          ),
          address: obj.loan?.address.toString(),
          symbol: obj.loan?.symbol.toString(),
        ),
        penalty: AmountRequest(
          amount: double.tryParse(
            penalty.value.isNotEmpty ? penalty.value : '0',
          ),
          address: obj.penalty?.address.toString(),
          symbol: obj.penalty?.symbol.toString(),
        ),
      ),
    );
    response.when(
      success: (response) {
        if (response.runtimeType == String) {
          checkPostRepay = response;
        } else {
          objRepayment = response;
          checkPostRepay = '';
        }
        showContent();
      },
      error: (error) {},
    );
  }

  Future<String> postRepaymentToBE({
    required String id,
    required String borrowWallet,
    required String lenderWallet,
    required String txnHash,
    required String interestAddress,
    required String interestAmount,
    required String interestSymbol,
    required String interestSystemFee,
    required String loanAddress,
    required String loanAmount,
    required String loanSymbol,
    required String loanSystemFee,
    required String penaltyAddress,
    required String penaltyAmount,
    required String penaltySymbol,
    required String penaltyFee,
    required String paymentRequestId,
  }) async {
    String success = '';
    final Map<String, dynamic> mapInterest = {
      'address': interestAddress,
      'amount': interestAmount == '' ? '0' : interestAmount,
      'symbol': interestSymbol,
      'systemFee': interestSystemFee,
    };
    final Map<String, dynamic> mapLoan = {
      'address': loanAddress,
      'amount': loanAmount == '' ? '0' : loanAmount,
      'symbol': loanSymbol,
      'systemFee': penaltyFee,
    };
    final Map<String, dynamic> mapPenalty = {
      'address': penaltyAddress,
      'amount': penaltyAmount == '' ? '0' : penaltyAmount,
      'symbol': penaltySymbol,
      'systemFee': interestSystemFee,
    };
    final Map<String, dynamic> map = {
      'borrowerWalletAddress': borrowWallet,
      'lenderWalletAddress': lenderWallet,
      'interest': mapInterest,
      'loan': mapLoan,
      'penalty': mapPenalty,
      'paymentRequestId': paymentRequestId,
      'txnHash': txnHash,
    };
    final Result<String> response =
        await _pawnService.confirmRepaymentToBe(id: id, map: map);
    response.when(
      success: (res) {
        if (res == 'success') {
          success = res;
        }
      },
      error: (err) {},
    );
    return success;
  }

  Future<void> getRepaymentPay({
    String? collateralId,
  }) async {
    id = collateralId ?? '';
    showLoading();
    final Result<dynamic> response = await _pawnService.getRepaymentPay(
      id: collateralId,
    );
    response.when(
      success: (response) {
        response as RepaymentRequestModel;
        maxInterest = (response.interest?.amount ?? 0) -
            (response.interest?.amountPaid ?? 0);
        maxLoan =
            (response.loan?.amount ?? 0) - (response.loan?.amountPaid ?? 0);
        maxPenalty = (response.penalty?.amount ?? 0) -
            (response.penalty?.amountPaid ?? 0);
        emit(
          RepaymentPaySuccess(
            CompleteType.SUCCESS,
            obj: response,
          ),
        );
      },
      error: (error) {
        if (error.code == CODE_ERROR_AUTH) {
          getRepaymentPay(collateralId: collateralId);
        }
        emit(
          RepaymentPaySuccess(
            CompleteType.ERROR,
            message: error.message,
          ),
        );
      },
    );
  }
}
