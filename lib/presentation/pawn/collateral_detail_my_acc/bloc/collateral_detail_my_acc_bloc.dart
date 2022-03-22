import 'package:rxdart/rxdart.dart';

class CollateralDetailMyAccBloc {
  BehaviorSubject<bool> isAddSend = BehaviorSubject.seeded(false);
  BehaviorSubject<bool> isAdd = BehaviorSubject.seeded(false);
}
