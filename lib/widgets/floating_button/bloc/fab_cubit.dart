import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'fab_state.dart';

class FabCubit extends Cubit<FabState> {
  FabCubit() : super(FabInitial());

  BehaviorSubject<bool> isAddingEvent = BehaviorSubject<bool>();

  void addToCancelOrReverse({required bool value}) {
    isAddingEvent.add(value);
  }

  void dispose() {
    isAddingEvent.close();
  }
}
