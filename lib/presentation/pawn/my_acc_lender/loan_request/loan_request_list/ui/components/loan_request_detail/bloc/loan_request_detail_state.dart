part of 'loan_request_detail_cubit.dart';

abstract class LoanRequestDetailState extends Equatable {
  const LoanRequestDetailState();
}

class LoanRequestDetailInitial extends LoanRequestDetailState {
  @override
  List<Object> get props => [];
}



class LoanRequestDetailLoadApi extends LoanRequestDetailState {

  final CompleteType completeType;
  final DetailLoanRequestCryptoModel? detailCrypto;

  LoanRequestDetailLoadApi(this.completeType, {this.detailCrypto});

  @override
  List<Object> get props => [completeType];
}
