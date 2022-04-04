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

  TypeRepayment type = TypeRepayment.PENALTY_INTEREST;
  BehaviorSubject<String> penalty = BehaviorSubject.seeded('');
  BehaviorSubject<String> interest = BehaviorSubject.seeded('');
  BehaviorSubject<String> loan = BehaviorSubject.seeded('');

  BehaviorSubject<bool> isBtn = BehaviorSubject.seeded(false);
  BehaviorSubject<String> isPenalty = BehaviorSubject.seeded('');
  BehaviorSubject<String> isInterest = BehaviorSubject.seeded('');
  BehaviorSubject<String> isLoan = BehaviorSubject.seeded('');
  String? hexString;

  BorrowRepository get _pawnService => Get.find();
  final Web3Utils web3Client = Web3Utils();
  double balancePenalty = 0;
  double balanceInterest = 0;
  double balanceLoan = 0;
  double maxInterest = 0;
  double maxLoan = 0;
  double maxPenalty = 0;
  String id = '';
  bool isChoose = true;
  RepaymentRequestModel objRepayment = RepaymentRequestModel.name();

  void validatePenalty(String value) {
    if (value.isNotEmpty) {
      if (double.parse(value) > balancePenalty) {
        isPenalty.add(S.current.invalid_amount);
        penalty.add('');
      } else if (double.parse(value) > maxPenalty) {
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
      } else if (double.parse(value) > maxLoan) {
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
      } else if (double.parse(value) > maxInterest) {
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
    final Result<RepaymentRequestModel> response =
        await _pawnService.postRepaymentPay(
      id: id,
      repaymentPayRequest: CalculateRepaymentRequest(
        interest: AmountRequest(
          amount: double.tryParse(interest.value),
          address: objRepayment.interest?.address.toString(),
          symbol: objRepayment.interest?.symbol.toString(),
        ),
        loan: AmountRequest(
          amount: double.tryParse(loan.value),
          address: objRepayment.loan?.address.toString(),
          symbol: objRepayment.loan?.symbol.toString(),
        ),
        penalty: AmountRequest(
          amount: double.tryParse(penalty.value),
          address: objRepayment.penalty?.address.toString(),
          symbol: objRepayment.penalty?.symbol.toString(),
        ),
      ),
    );
    response.when(
      success: (response) {
        objRepayment = response;
      },
      error: (error) {},
    );
  }

  Future<void> getRepaymentPay({
    String? collateralId,
  }) async {
    id = collateralId ?? '';
    showLoading();
    final Result<RepaymentRequestModel> response =
        await _pawnService.getRepaymentPay(
      id: collateralId,
    );
    response.when(
      success: (response) {
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
