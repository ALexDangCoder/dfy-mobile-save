part of 'send_loan_request_cubit.dart';

@immutable
abstract class SendLoanRequestState extends Equatable {}

class SendLoanRequestInitial extends SendLoanRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetWalletSuccess extends SendLoanRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NoLogin extends SendLoanRequestState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ListSelectNftCollateralGetApi extends SendLoanRequestState {
  final List<ContentNftOnRequestLoanModel>? list;
  final CompleteType completeType;
  final String? message;


  ListSelectNftCollateralGetApi(this.completeType, {this.list, this.message});

  @override
  List<Object?> get props => [list];
}


