import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class LendingRegistrationAcceptState extends Equatable {}

class LendingRegistrationAcceptInitial extends LendingRegistrationAcceptState {
  @override
  List<Object?> get props => [];
}

class LendingRegistrationAcceptLoading extends LendingRegistrationAcceptState {
  @override
  List<Object?> get props => [];
}

class LendingRegistrationAcceptSuccess extends LendingRegistrationAcceptState {
  final int id = DateTime.now().millisecond;
  final CompleteType completeType;
  final String? message;

  LendingRegistrationAcceptSuccess(
      this.completeType, {
        this.message,
      });

  @override
  List<Object?> get props => [id, completeType, message];
}
