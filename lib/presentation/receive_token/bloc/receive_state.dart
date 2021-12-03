import 'package:equatable/equatable.dart';

abstract class ReceiveState extends Equatable {
  @override
  List<Object> get props => [];
}

class ReceiveInitial extends ReceiveState {}
