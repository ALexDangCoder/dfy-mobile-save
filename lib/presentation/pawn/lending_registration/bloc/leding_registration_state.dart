import 'package:Dfy/domain/model/home_pawn/history_detail_collateral_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class LendingRegistrationState extends Equatable {}

class LendingRegistrationInitial extends LendingRegistrationState {
  @override
  List<Object?> get props => [];
}

class LendingRegistrationLoading extends LendingRegistrationState {
  @override
  List<Object?> get props => [];
}

class LendingRegistrationSuccess extends LendingRegistrationState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<HistoryCollateralModel>? list;
  final String? message;

  LendingRegistrationSuccess(
      this.completeType, {
        this.list,
        this.message,
      });

  @override
  List<Object?> get props => [id, completeType, list, message];
}
