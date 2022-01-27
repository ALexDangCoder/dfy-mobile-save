import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:equatable/equatable.dart';

abstract class ApproveState extends Equatable {}

class ApproveInitState extends ApproveState {
  @override
  List<Object?> get props => [];
}

class GotDataApprove extends ApproveState {
  @override
  List<Object?> get props => [];
}

class SignSuccess extends ApproveState {
  final String txh;
  final TYPE_CONFIRM_BASE type;

  SignSuccess(this.txh, this.type);

  @override
  List<Object?> get props => [txh, type];
}


class ApproveFail extends ApproveState {

  ApproveFail();

  @override
  List<Object?> get props => [];
}

class ApproveSuccess extends ApproveState {

  ApproveSuccess();

  @override
  List<Object?> get props => [];
}

class SignFail extends ApproveState {
  final String message;
  final TYPE_CONFIRM_BASE type;

  SignFail(this.message, this.type);

  @override
  List<Object?> get props => [];
}

class CancelSuccess extends ApproveState{
  final String txnHash;

  CancelSuccess(this.txnHash);

  @override
  List<Object?> get props => [txnHash];

}
