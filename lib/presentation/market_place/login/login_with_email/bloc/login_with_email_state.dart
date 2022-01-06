part of 'login_with_email_cubit.dart';

@immutable
abstract class LoginWithEmailState {
  final String errText = '';
}

class LoginWithEmailInitial extends LoginWithEmailState {
}

class ValidateSuccess extends LoginWithEmailState{}

class EmailInvalid extends LoginWithEmailState{
  @override
  String get errText => S.current.email_invalid;
}

class EmailTooLong extends LoginWithEmailState{
  @override
  String get errText => S.current.email_too_long;
}

class EmailHasExist extends LoginWithEmailState{}


