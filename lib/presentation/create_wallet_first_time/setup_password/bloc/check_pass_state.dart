part of 'check_pass_cubit.dart';

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

class ShowPassState extends CheckPassState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

}
