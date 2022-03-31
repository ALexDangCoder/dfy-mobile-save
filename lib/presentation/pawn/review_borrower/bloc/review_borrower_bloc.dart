import 'package:rxdart/rxdart.dart';

class ReviewBorrowerBloc {
  BehaviorSubject<int> rateNumber = BehaviorSubject.seeded(0);
  BehaviorSubject<bool> isCheckBox = BehaviorSubject.seeded(false);
  String? hexString;
}
