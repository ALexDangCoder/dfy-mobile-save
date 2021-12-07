part of 'login_cubit.dart';

@immutable
abstract class LoginState extends Equatable{}

class LoginInitial extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginLoading extends LoginState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LoginError extends LoginState {

  final String error;
  LoginError(this.error);
  @override
  List<Object?> get props => [error];

}
class LoginSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}
class LoginPasswordSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}
class LoginPasswordError extends LoginState {

  @override
  List<Object?> get props => [];

}

