
import 'package:Dfy/domain/model/pawn/contract_detail_pawn.dart';
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
  final ContractDetailPawn? obj;
  final String? message;

  ContractDetailSuccess(
      this.completeType, {
        this.obj,
        this.message,
      });

  @override
  List<Object?> get props => [id, completeType, obj, message];
}
