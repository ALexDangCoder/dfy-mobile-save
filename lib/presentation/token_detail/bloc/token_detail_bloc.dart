import 'dart:math' hide log;
import 'package:Dfy/generated/l10n.dart';
import 'package:rxdart/rxdart.dart';

class TokenDetailBloc {
  static const len_mock_data = 40;
  final List<String> mockData =
      List.generate(len_mock_data, (index) => S.current.contract_interaction);
  final List<int> mockType =
      List.generate(len_mock_data, (index) => Random().nextInt(3));
  final List<DateTime> mockDate =
      List.generate(len_mock_data, (index) => DateTime.now());
  final List<int> mockAmount =
      List.generate(len_mock_data, (index) => Random().nextInt(5000));

  int dataListLen = 4;
  List<String> transactionList = [];

  final BehaviorSubject<List<String>> _transactionListSubject =
      BehaviorSubject();

  final BehaviorSubject<bool> _showMoreSubject = BehaviorSubject();

  Stream<List<String>> get transactionListStream =>
      _transactionListSubject.stream;

  Stream<bool> get showMoreStream => _showMoreSubject.stream;

  void test() {
    _transactionListSubject.sink.add(mockData);
  }

  void checkData() {
    if (mockData.length <= dataListLen) {
      _transactionListSubject.sink.add(mockData);
      hideShowMore();
    } else {
      transactionList = mockData.sublist(0, dataListLen);
      _transactionListSubject.sink.add(transactionList);
      _showMoreSubject.sink.add(true);
    }
  }

  void showMore() {
    if (mockData.length - transactionList.length > 10) {
      transactionList.addAll(
        mockData.sublist(transactionList.length, transactionList.length + 10),
      );
    } else {
      transactionList = mockData;
      hideShowMore();
    }
    _transactionListSubject.sink.add(transactionList);
  }

  void hideShowMore() {
    _showMoreSubject.sink.add(false);
  }
}
