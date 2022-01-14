import 'package:equatable/equatable.dart';

abstract class ApproveState extends Equatable {}

class ApproveInitState extends ApproveState {
  @override
  List<Object?> get props => [];
}

class BuySuccess extends ApproveState {
  final String txh;

  BuySuccess(this.txh);

  @override
  List<Object?> get props => [txh];
}

class BuyFail extends ApproveState {
  @override
  List<Object?> get props => [];
}

class SendRawDataSuccess extends ApproveState{
  String txnHash;

  SendRawDataSuccess(this.txnHash);

  @override
  // TODO: implement props
  List<Object?> get props => [txnHash];

}