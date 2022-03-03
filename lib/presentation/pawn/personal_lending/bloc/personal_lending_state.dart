

import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class PersonalLendingState extends Equatable {}

class PersonalLendingInitial extends PersonalLendingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonalLendingLoading extends PersonalLendingState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PersonalLendingSuccess extends PersonalLendingState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<PawnShopModel>? listPawn;
  final String? message;

  PersonalLendingSuccess(this.completeType, {this.listPawn, this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [id, completeType, listPawn, message];
}
