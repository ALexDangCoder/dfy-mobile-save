import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'lender_loan_request_state.dart';

class LenderLoanRequestCubit extends Cubit<LenderLoanRequestState> {
  LenderLoanRequestCubit() : super(LenderLoanRequestInitial());

  List<Map<String, dynamic>> durationList = [
    {
      'value': 'month',
      'label': 'month',
    },
    {
      'value': 'week',
      'label': 'week',
    }
  ];
}
