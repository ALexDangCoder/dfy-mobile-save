part of 'timer_bloc.dart';

class TimeState extends Equatable {
  final int timeDuration;

  const TimeState(this.timeDuration);

  @override
  List<Object?> get props => [timeDuration];
}

class InitialState extends TimeState {
  final int timeDuration;

  const InitialState(this.timeDuration) : super(timeDuration);
}

class RunningState extends TimeState {
  final int timeDuration;

  const RunningState(this.timeDuration) : super(timeDuration);
}

class PauseState extends TimeState {
  final int timeDuration;

  const PauseState(this.timeDuration) : super(timeDuration);
}

class CompletedState extends TimeState {
  const CompletedState() : super(0);
}
