import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'timer_event.dart';

part 'timer_state.dart';

class TimeBloc extends Bloc<TimeEvent, TimeState> {
  static const int _timeDuration = 12000;

  StreamSubscription<int>? _timeSubsctiption;

  TimeBloc() : super(const InitialState(_timeDuration));

  @override
  Stream<TimeState> mapEventToState(TimeEvent event) async* {
    if (event is StartEvent) {
      yield RunningState(event.timeDuration);
      await _timeSubsctiption?.cancel();
      _timeSubsctiption = changeTime(event.timeDuration).listen((event) {
        return add(RunEvent(event));
      });
    } else if (event is RunEvent) {
      yield event.timeDuration > 0
          ? RunningState(event.timeDuration)
          : const CompletedState();
    } else if (event is PauseEvent) {
      _timeSubsctiption?.pause();
      yield PauseState(state.timeDuration);
    } else if (event is ResumeEvent) {
      _timeSubsctiption?.resume();
      yield RunningState(state.timeDuration);
    } else if (event is ResetEvent) {
      await _timeSubsctiption?.cancel();
      yield const InitialState(_timeDuration);
    }
  }

  Stream<int> changeTime(int time) {
    return Stream.periodic(const Duration(seconds: 1), (x) => time - x - 1)
        .take(time);
  }
}
