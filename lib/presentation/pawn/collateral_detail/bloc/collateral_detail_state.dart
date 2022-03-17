import 'package:Dfy/domain/model/pawn/detail_collateral.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class CollateralDetailState extends Equatable {}

class CollateralDetailInitial extends CollateralDetailState {
  @override
  List<Object?> get props => [];
}

class CollateralDetailLoading extends CollateralDetailState {
  @override
  List<Object?> get props => [];
}

class CollateralDetailSuccess extends CollateralDetailState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final CollateralDetail? obj;
  final String? message;

  CollateralDetailSuccess(
    this.completeType, {
    this.obj,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, obj, message];
}
