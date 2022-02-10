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

  SignSuccess(this.txh);

  @override
  List<Object?> get props => [txh];
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

  SignFail(this.message);

  @override
  List<Object?> get props => [];
}

class CancelSuccess extends ApproveState{
  final String txnHash;

  CancelSuccess(this.txnHash);

  @override
  List<Object?> get props => [txnHash];

}
