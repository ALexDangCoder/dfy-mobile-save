import 'package:rxdart/rxdart.dart';

class NFTBloc {
  final BehaviorSubject<int> _lengthSubject = BehaviorSubject<int>();
  final BehaviorSubject<bool> _showSubject = BehaviorSubject<bool>();
  Stream<int> get lenStream => _lengthSubject.stream;
  Sink<int> get lenSink => _lengthSubject.sink;
  int get curLen => _lengthSubject.valueOrNull ?? 0;
  Stream<bool> get showStream => _showSubject.stream;
  Sink<bool> get showSink => _showSubject.sink;
  void dispose() {
    _lengthSubject.close();
  }
}
