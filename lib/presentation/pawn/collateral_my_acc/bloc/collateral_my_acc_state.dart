import 'package:Dfy/domain/model/pawn/collateral_result_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class CollateralMyAccState extends Equatable {}

class CollateralMyAccInitial extends CollateralMyAccState {
  @override
  List<Object?> get props => [];
}

class CollateralMyAccLoading extends CollateralMyAccState {
  @override
  List<Object?> get props => [];
}

class CollateralMyAccSuccess extends CollateralMyAccState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<CollateralResultModel>? listCollateral;
  final String? message;

  CollateralMyAccSuccess(
    this.completeType, {
    this.listCollateral,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, listCollateral, message];
}
