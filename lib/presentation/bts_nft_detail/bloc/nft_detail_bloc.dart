import 'dart:developer';

import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/detail_history_nft.dart';
import 'package:Dfy/domain/model/history_nft.dart';
import 'package:rxdart/rxdart.dart';

class NFTBloc {
  final BehaviorSubject<int> _lengthSubject = BehaviorSubject<int>();
  final BehaviorSubject<bool> _showSubject = BehaviorSubject<bool>();
  final BehaviorSubject<List<HistoryNFT>> _historySubject =
      BehaviorSubject<List<HistoryNFT>>();

  Stream<List<HistoryNFT>> get historyStream => _historySubject.stream;

  Sink<List<HistoryNFT>> get historySink => _historySubject.sink;

  List<HistoryNFT> listHistory = [];
  List<DetailHistoryNFT> listDetailHistory = [];

  Stream<int> get lenStream => _lengthSubject.stream;

  Sink<int> get lenSink => _lengthSubject.sink;

  int get curLen => _lengthSubject.valueOrNull ?? 0;

  Stream<bool> get showStream => _showSubject.stream;

  Sink<bool> get showSink => _showSubject.sink;
  final Web3Utils _client = Web3Utils();

  Future<void> getTransactionNFTHistory() async {
    listHistory = await _client.getNFTHistory();
    historySink.add(listHistory);
  }

  void dispose() {
    _lengthSubject.close();
  }
}
