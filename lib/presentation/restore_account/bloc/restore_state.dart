import 'package:Dfy/data/exception/app_exception.dart';
import 'package:Dfy/domain/model/wallet.dart';
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
  @override
  List<Object?> get props => [];
}
class ExceptionState extends RestoreState {
  String message;

  ExceptionState(this.message);

  @override
  List<Object?> get props => [];
}
