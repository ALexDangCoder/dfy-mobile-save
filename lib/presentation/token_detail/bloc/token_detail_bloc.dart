import 'package:rxdart/rxdart.dart';

class TokenDetailBloc {
  List<String> transactionList = [];

  final BehaviorSubject<List<String>> _transactionListSubject =
      BehaviorSubject.seeded([]);

  Stream<List<String>> get transactionListStream =>
      _transactionListSubject.stream;
}
