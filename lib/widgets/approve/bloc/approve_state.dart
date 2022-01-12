import 'package:equatable/equatable.dart';

abstract class ApproveState extends Equatable {}

class ApproveInitState extends ApproveState {
  @override
  List<Object?> get props => [];
}
class BuySuccess extends ApproveState {
  @override
  List<Object?> get props => [];
}
class BuyFail extends ApproveState {
  @override
  List<Object?> get props => [];
}