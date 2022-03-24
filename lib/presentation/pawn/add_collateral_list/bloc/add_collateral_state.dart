import 'package:Dfy/domain/model/home_pawn/history_detail_collateral_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class AddCollateralState extends Equatable {}

class AddCollateralInitial extends AddCollateralState {
  @override
  List<Object?> get props => [];
}

class AddCollateralLoading extends AddCollateralState {
  @override
  List<Object?> get props => [];
}

class AddCollateralSuccess extends AddCollateralState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<HistoryCollateralModel>? list;
  final String? message;

  AddCollateralSuccess(
    this.completeType, {
    this.list,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, list, message];
}
