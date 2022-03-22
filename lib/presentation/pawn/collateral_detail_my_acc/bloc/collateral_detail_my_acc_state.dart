import 'package:Dfy/domain/model/home_pawn/collateral_detail_my_acc_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class CollateralDetailMyAccState extends Equatable {}

class CollateralDetailMyAccInitial extends CollateralDetailMyAccState {
  @override
  List<Object?> get props => [];
}

class CollateralDetailMyAccLoading extends CollateralDetailMyAccState {
  @override
  List<Object?> get props => [];
}

class CollateralDetailMyAccSuccess extends CollateralDetailMyAccState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final CollateralDetailMyAcc? obj;
  final String? message;

  CollateralDetailMyAccSuccess(
    this.completeType, {
    this.obj,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, obj, message];
}
