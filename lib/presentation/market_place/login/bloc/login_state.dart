part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class HasNoWallet extends LoginState{}

class NeedLoginToUse extends LoginState{}
