import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class AddMoreCollateralState extends Equatable {}

class AddMoreCollateralInitial extends AddMoreCollateralState {
  @override
  List<Object?> get props => [];
}

class AddMoreCollateralLoading extends AddMoreCollateralState {
  @override
  List<Object?> get props => [];
}

class AddMoreCollateralSuccess extends AddMoreCollateralState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final String? message;

  AddMoreCollateralSuccess(
      this.completeType, {
        this.message,
      });

  @override
  List<Object?> get props => [id, completeType, message];
}
