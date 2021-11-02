import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'setup_password_event.dart';
part 'setup_password_state.dart';

class SetupPasswordBloc extends Bloc<SetupPasswordEvent, SetupPasswordState> {
  SetupPasswordBloc() : super(SetupPasswordInitial()) {
    on<SetupPasswordEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
