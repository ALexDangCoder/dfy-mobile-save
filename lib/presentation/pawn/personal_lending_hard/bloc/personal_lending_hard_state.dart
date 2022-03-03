import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class PersonalLendingHardState extends Equatable {}

class PersonalLendingHardInitial extends PersonalLendingHardState {
  @override
  List<Object?> get props => [];
}

class PersonalLendingHardLoading extends PersonalLendingHardState {
  @override
  List<Object?> get props => [];
}

class PersonalLendingHardSuccess extends PersonalLendingHardState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<PersonalLending>? listPersonal;
  final String? message;

  PersonalLendingHardSuccess(
    this.completeType, {
    this.listPersonal,
    this.message,
  });

  @override
  List<Object?> get props => [id, completeType, listPersonal, message];
}
