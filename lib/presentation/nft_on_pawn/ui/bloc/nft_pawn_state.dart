import 'package:equatable/equatable.dart';

abstract class PawnState extends Equatable {
  @override
  List<Object> get props => [];
}
class PawnInitial extends PawnState{}