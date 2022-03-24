
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class ContractDetailState extends Equatable {}

class ContractDetailInitial extends ContractDetailState {
  @override
  List<Object?> get props => [];
}

class ContractDetailLoading extends ContractDetailState {
  @override
  List<Object?> get props => [];
}

class ContractDetailSuccess extends ContractDetailState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<dynamic>? listContract;
  final String? message;

  ContractDetailSuccess(
      this.completeType, {
        this.listContract,
        this.message,
      });

  @override
  List<Object?> get props => [id, completeType, listContract, message];
}
