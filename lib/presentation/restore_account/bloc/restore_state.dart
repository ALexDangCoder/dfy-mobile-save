
import 'package:equatable/equatable.dart';

abstract class RestoreState extends Equatable {}

class RestoreInitial extends RestoreState {
  @override
  List<Object?> get props => [];
}

class NavState extends RestoreState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends RestoreState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object?> get props => [];
}
class ExceptionState extends RestoreState {
  String message;

  ExceptionState(this.message);

  @override
  List<Object?> get props => [];
}
