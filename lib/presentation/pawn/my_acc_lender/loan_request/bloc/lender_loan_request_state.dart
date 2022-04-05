part of 'lender_loan_request_cubit.dart';

abstract class LenderLoanRequestState extends Equatable {
  const LenderLoanRequestState();
}

class LenderLoanRequestInitial extends LenderLoanRequestState {
  @override
  List<Object> get props => [];
}

class LoadLoanRequestResult extends LenderLoanRequestState {
  final List<LoanRequestCryptoModel>? list;
  final CompleteType completeType;

  LoadLoanRequestResult(
    this.completeType, {
    this.list,
  });

  @override
  List<Object?> get props => [list, completeType,];
}

class LoadMoreCrypto extends LenderLoanRequestState {
  @override
  List<Object> get props => [];
}

class LoadCryptoFail extends LenderLoanRequestState {
  @override
  List<Object> get props => [];
}
