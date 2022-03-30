
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class RepaymentHistoryDetailState extends Equatable {}

class RepaymentHistoryDetailInitial extends RepaymentHistoryDetailState {
  @override
  List<Object?> get props => [];
}

class RepaymentHistoryDetailLoading extends RepaymentHistoryDetailState {
  @override
  List<Object?> get props => [];
}

class RepaymentHistoryDetailSuccess extends RepaymentHistoryDetailState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<RepaymentRequestModel>? list;
  final String? message;

  RepaymentHistoryDetailSuccess(
    this.completeType, {
    this.list,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, list, message];
}
