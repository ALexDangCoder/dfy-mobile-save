import 'package:equatable/equatable.dart';

abstract class MenuAccountState extends Equatable {}

class LogonState extends MenuAccountState {
  @override
  List<Object?> get props => [];
}

class NoLoginState extends MenuAccountState {
  @override
  List<Object?> get props => [];
}
