import 'package:event_bus/event_bus.dart';

final EventBus eventBus = EventBus();

class UnAuthEvent {
  final String message;

  UnAuthEvent(this.message);
}
class TimeOutEvent {
  final String message;

  TimeOutEvent(this.message);
}

class OpenMainTabIndex {
  final int tabIndex;

  OpenMainTabIndex(this.tabIndex);
}
