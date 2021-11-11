import 'package:Dfy/generated/l10n.dart';
import 'package:rxdart/rxdart.dart';

class TokenDetailBloc {

  List<String> transactionList = [];

  final BehaviorSubject<List<String>> _transactionListSubject =
      BehaviorSubject.seeded([]);

  Stream<List<String>> get transactionListStream =>
      _transactionListSubject.stream;

  void test (){
  _transactionListSubject.sink.add(['1,2']);
  }
}
