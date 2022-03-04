import 'package:Dfy/domain/model/pawn/pawn_shop_model.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class PawnListState extends Equatable {}

class PawnListInitial extends PawnListState {
  @override
  List<Object?> get props => [];
}

class PawnListLoading extends PawnListState {
  @override
  List<Object?> get props => [];
}

class PawnListSuccess extends PawnListState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<PawnShopModel>? listPawn;
  final String? message;

  PawnListSuccess(
    this.completeType, {
    this.listPawn,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, listPawn, message];
}
