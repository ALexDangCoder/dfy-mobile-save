import 'package:Dfy/config/base/base_cubit.dart';
import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/data/request/pawn/repayment_pay_request.dart';
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

  BehaviorSubject<String> isPenalty = BehaviorSubject.seeded('');
  BehaviorSubject<String> isInterest = BehaviorSubject.seeded('');
  BehaviorSubject<String> isLoan = BehaviorSubject.seeded('');

  BorrowRepository get _pawnService => Get.find();
  final Web3Utils web3Client = Web3Utils();
  double balancePenalty = 0;
  double balanceInterest = 0;
  double balanceLoan = 0;
  String id = '';

  void validatePenalty(String value) {
    if (value.isNotEmpty) {
      if (double.parse(value) > balancePenalty) {
        isPenalty.add(S.current.invalid_amount);
      } else {
        isPenalty.add('');
      }
    } else {
      isPenalty.add(S.current.value_is_required);
    }
  }

  void validateLoan(String value) {
    if (value.isNotEmpty) {
      if (double.parse(value) > balanceLoan) {
        isLoan.add(S.current.invalid_amount);
      } else {
        isLoan.add('');
      }
    } else {
      isLoan.add(S.current.value_is_required);
    }
  }

  void validateInterest(String value) {
    if (value.isNotEmpty) {
      if (double.parse(value) > balanceInterest) {
        isInterest.add(S.current.invalid_amount);
      } else {
        isInterest.add('');
      }
    } else {
      isInterest.add(S.current.value_is_required);
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
      repaymentPayRequest: RepaymentPayRequest(
        interest: AmountRequest(
          amount: double.tryParse(interest.value),
        ),
        loan: AmountRequest(
          amount: double.tryParse(loan.value),
        ),
        penalty: AmountRequest(
          amount: double.tryParse(penalty.value),
        ),
      ),
    );
    response.when(
      success: (response) {},
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
