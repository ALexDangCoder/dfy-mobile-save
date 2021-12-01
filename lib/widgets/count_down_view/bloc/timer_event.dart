part of 'timer_bloc.dart';


class TimeEvent extends Equatable {
  const TimeEvent();

  @override
  List<Object?> get props => [];
}

class StartEvent extends TimeEvent {
  final int timeDuration;
  const StartEvent(this.timeDuration);
}

class RunEvent extends TimeEvent {
  final int timeDuration;

  const RunEvent(this.timeDuration);
}

class PauseEvent extends TimeEvent {}

class ResumeEvent extends TimeEvent {}

class ResetEvent extends TimeEvent {}
