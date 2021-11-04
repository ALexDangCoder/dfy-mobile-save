import 'package:equatable/equatable.dart';

abstract class CheckPassState extends Equatable {
  const CheckPassState();
}

class CheckPassInitial extends CheckPassState {
  @override
  List<Object> get props => [];
}

class ValidatePWState extends CheckPassState {
  @override
  List<Object> get props => [];
}

class MatchPassState extends CheckPassState {
  @override
  List<Object> get props => [];
}


