import 'package:Dfy/widgets/approve/bloc/approve_cubit.dart';
import 'package:equatable/equatable.dart';

abstract class ApproveState extends Equatable {}

class ApproveInitState extends ApproveState {
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

class SignFail extends ApproveState {
  @override
  List<Object?> get props => [];
}

class SendRawData extends ApproveState {
  final String txnHash;
  final bool isSuccess;

  SendRawData(this.txnHash, {this.isSuccess = false});

  @override
  // TODO: implement props
  List<Object?> get props => [txnHash, isSuccess];
}
