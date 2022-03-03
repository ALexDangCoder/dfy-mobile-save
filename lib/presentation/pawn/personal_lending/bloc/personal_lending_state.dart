import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class PersonalLendingState extends Equatable {}

class PersonalLendingInitial extends PersonalLendingState {
  @override
  List<Object?> get props => [];
}

class PersonalLendingLoading extends PersonalLendingState {
  @override
  List<Object?> get props => [];
}

class PersonalLendingSuccess extends PersonalLendingState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final List<PersonalLending>? listPersonal;
  final String? message;

  PersonalLendingSuccess(this.completeType, {this.listPersonal, this.message});

  @override
  List<Object?> get props => [id, completeType, listPersonal, message];
}
