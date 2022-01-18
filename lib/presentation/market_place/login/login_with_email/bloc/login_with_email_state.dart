part of 'login_with_email_cubit.dart';

@immutable
abstract class LoginWithEmailState extends Equatable {
}

class LoginWithEmailInitial extends LoginWithEmailState {
  @override
  List<Object?> get props => [];
}

class ValidateSuccess extends LoginWithEmailState{
  @override
  List<Object?> get props => [];
}

class EmailInvalid extends LoginWithEmailState{
  final String errText;

  EmailInvalid({required this.errText});

  @override
  List<Object?> get props => [errText];
}

class EmailTooLong extends LoginWithEmailState{
  final String errText;

  EmailTooLong({required this.errText});

  @override
  List<Object?> get props => [errText];
}

class TimerCountDown extends LoginWithEmailState{
  final int count;

  TimerCountDown(this.count);

  @override
  List<Object?> get props => [count];
}

class TimerEnd extends LoginWithEmailState{
  final int count;

  TimerEnd(this.count);

  @override
  List<Object?> get props => [count];
}

class RefreshTimer extends LoginWithEmailState{
  final int count;

  RefreshTimer(this.count);

  @override
  List<Object?> get props => [count];
}



