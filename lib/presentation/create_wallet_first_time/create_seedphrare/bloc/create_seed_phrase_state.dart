import 'package:equatable/equatable.dart';

abstract class SeedState extends Equatable {
  @override
  List<Object> get props => [];
}

class SeedInitialState extends SeedState {}

class SeedNavState extends SeedState {}
