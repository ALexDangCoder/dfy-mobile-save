import 'package:equatable/equatable.dart';

abstract class ExampleState extends Equatable {
  const ExampleState();
}

class ProductDetailInitial extends ExampleState {
  @override
  List<Object> get props => [];
}

class LoadingState extends ExampleState {
  @override
  List<Object> get props => [];
}
