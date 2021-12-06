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
  DetailHistoryNFT listDetailHistory = DetailHistoryNFT(
    0,
    'Fail',
    0.0,
    '2021-12-03 14:30',
    '0xc945bb101ac51f0bbb77c294fe21280e9de55c82da3160ad665548ef8662f35a',
    '0x588B1b7C48517D1C8E1e083d4c05389D2E1A5e37',
    '0xf14aEdedE46Bf6763EbB5aA5C882364d29B167dD',
    2409,
  );

  Stream<int> get lenStream => _lengthSubject.stream;

  Sink<int> get lenSink => _lengthSubject.sink;

  int get curLen => _lengthSubject.valueOrNull ?? 0;

  Stream<bool> get showStream => _showSubject.stream;

  Sink<bool> get showSink => _showSubject.sink;
  final Web3Utils _client = Web3Utils();

  Future<void> getTransactionNFTHistory() async {
    listHistory = await _client.getNFTHistory();
    historySink.add(listHistory);
    listDetailHistory = await _client.getNFTHistoryDetail();
  }

  void dispose() {
    _lengthSubject.close();
  }
}
