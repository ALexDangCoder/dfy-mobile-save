part of 'send_loan_request_cubit.dart';

@immutable
abstract class SendLoanRequestState extends Equatable {}

class SendLoanRequestInitial extends SendLoanRequestState {
  @override
  List<Object?> get props => [];
}

class GetWalletSuccess extends SendLoanRequestState {
  @override
  List<Object?> get props => [];
}

class NoLogin extends SendLoanRequestState {
  @override
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

class ListSelectNftLoadMore extends SendLoanRequestState {
  @override
  List<Object?> get props => [];
}

class ListSelectNftLoading extends SendLoanRequestState {
  @override
  List<Object?> get props => [];
}

class SubmittingNft extends SendLoanRequestState {
  @override
  List<Object?> get props => [];
}

class SubmitNftSuccess extends SendLoanRequestState {

  final CompleteType complete;

  SubmitNftSuccess(this.complete);

  @override
  List<Object?> get props => [];
}






