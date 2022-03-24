import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class CreateNewCollateralState extends Equatable {}

class CreateNewCollateralInitial extends CreateNewCollateralState {
  @override
  List<Object?> get props => [];
}

class CreateNewCollateralLoading extends CreateNewCollateralState {
  @override
  List<Object?> get props => [];
}

class CreateNewCollateralSuccess extends CreateNewCollateralState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final String? message;

  CreateNewCollateralSuccess(
    this.completeType, {
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, message];
}
