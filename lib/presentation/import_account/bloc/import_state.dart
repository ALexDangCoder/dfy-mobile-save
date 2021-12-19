import 'package:equatable/equatable.dart';

abstract class ImportState extends Equatable {}

class ImportInitial extends ImportState {
  @override
  List<Object?> get props => [];
}

class NavState extends ImportState {
  @override
  List<Object?> get props => [];
}

class ErrorState extends ImportState {
  @override
  List<Object?> get props => [];
}

class ExceptionState extends ImportState {
  String message;

  ExceptionState(this.message);

  @override
  List<Object?> get props => [];
}
