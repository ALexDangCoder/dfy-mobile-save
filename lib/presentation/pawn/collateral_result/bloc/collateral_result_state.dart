import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class CollateralResultState extends Equatable {}

class CollateralResultInitial extends CollateralResultState {
  @override
  List<Object?> get props => [];
}

class CollateralResultLoading extends CollateralResultState {
  @override
  List<Object?> get props => [];
}

class CollateralResultSuccess extends CollateralResultState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<CollateralResultModel>? listCollateral;
  final String? message;

  CollateralResultSuccess(
    this.completeType, {
    this.listCollateral,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, listCollateral, message];
}
