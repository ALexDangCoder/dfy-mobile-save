import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_form_event.dart';
part 'my_form_state.dart';

class MyFormBloc extends Bloc<MyFormEvent, MyFormState> {
  MyFormBloc() : super(MyFormInitial()) {
    on<MyFormEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
