part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();
}

class ChangePasswordInitial extends ChangePasswordState {
  @override
  List<Object> get props => [];
}

class ChangePasswordSuccess extends ChangePasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ChangePasswordFail extends ChangePasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
