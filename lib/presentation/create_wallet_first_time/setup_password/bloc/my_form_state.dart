part of 'my_form_bloc.dart';

abstract class MyFormState extends Equatable {
  const MyFormState();
}

class MyFormInitial extends MyFormState {
  @override
  List<Object> get props => [];
}
