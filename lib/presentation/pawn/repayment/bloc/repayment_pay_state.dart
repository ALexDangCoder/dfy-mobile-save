import 'package:Dfy/domain/model/home_pawn/collateral_detail_my_acc_model.dart';
import 'package:Dfy/domain/model/pawn/repayment_request_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class RepaymentPayState extends Equatable {}

class RepaymentPayInitial extends RepaymentPayState {
  @override
  List<Object?> get props => [];
}

class RepaymentPayLoading extends RepaymentPayState {
  @override
  List<Object?> get props => [];
}

class RepaymentPaySuccess extends RepaymentPayState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final RepaymentRequestModel? obj;
  final String? message;

  RepaymentPaySuccess(
    this.completeType, {
    this.obj,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, obj, message];
}
