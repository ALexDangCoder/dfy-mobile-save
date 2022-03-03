import 'package:Dfy/config/base/base_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_loan_request_state.dart';

class SendLoanRequestCubit extends BaseCubit<SendLoanRequestState> {
  SendLoanRequestCubit() : super(SendLoanRequestInitial());
}
