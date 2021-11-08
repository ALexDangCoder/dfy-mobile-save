import 'package:equatable/equatable.dart';

abstract class RestoreState extends Equatable {}

class RestoreInitial extends RestoreState {
  @override
  List<Object?> get props => [];
}
