import 'package:Dfy/data/web3/model/transaction.dart';
import 'package:Dfy/data/web3/model/transaction_history_detail.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:rxdart/rxdart.dart';

class TokenDetailBloc {
  final String walletAddress;
  final Web3Utils _web3client = Web3Utils();

  TokenDetailBloc({
    required this.walletAddress,
  });

  int minLen = 4;
  List<TransactionHistory> totalTransactionList = [];
  List<TransactionHistory> currentTransactionList = [];

  final BehaviorSubject<List<TransactionHistory>> _transactionListSubject =
      BehaviorSubject();
  Stream<List<TransactionHistory>> get transactionListStream =>
      _transactionListSubject.stream;

  final BehaviorSubject<bool> _showMoreSubject = BehaviorSubject();
  Stream<bool> get showMoreStream => _showMoreSubject.stream;

  final BehaviorSubject<bool> _showLoadingSubject = BehaviorSubject();
  Stream<bool> get showLoadingStream => _showLoadingSubject.stream;

  final BehaviorSubject<TransactionHistoryDetail>
      _transactionHistoryDetailSubject = BehaviorSubject();
  Stream<TransactionHistoryDetail> get transactionHistoryStream =>
      _transactionHistoryDetailSubject.stream;

  final BehaviorSubject<ModelToken> _tokenSubject = BehaviorSubject();
  Stream <ModelToken> get tokenStream => _tokenSubject.stream;

  ///Get functions
  ///Get list Transaction and detail Transaction
  Future<void> getTransaction({
    required String txhId,
  }) async {
    final result = await _web3client.getHistoryDetail(txhId: txhId);
    _transactionHistoryDetailSubject.sink.add(result);
  }
  Future<void> getHistory(String _tokenAddress) async {
    final result = await _web3client.getTransactionHistory(
      ofAddress: walletAddress,
      tokenAddress: _tokenAddress,
    );
    totalTransactionList = result;
    checkData();
  }

  ///ShowTransactionHistory
  void checkData() {
    if (totalTransactionList.length <= minLen) {
      _transactionListSubject.sink.add(totalTransactionList);
      _showMoreSubject.sink.add(false);
    } else {
      currentTransactionList = totalTransactionList.sublist(0, minLen);
      _transactionListSubject.sink.add(currentTransactionList);
      _showMoreSubject.sink.add(true);
    }
  }

  void showMore() {
    if (totalTransactionList.length - currentTransactionList.length > 10) {
      currentTransactionList.addAll(
        totalTransactionList.sublist(
            currentTransactionList.length, currentTransactionList.length + 10),
      );
    } else {
      currentTransactionList = totalTransactionList;
      _showMoreSubject.sink.add(false);

    }
    _transactionListSubject.sink.add(currentTransactionList);
  }

  ///showLoading
  Future<void> checkShowLoading() async {
    _showLoadingSubject.sink.add(true);
    await Future.delayed(const Duration(seconds: 3));
    _showLoadingSubject.sink.add(false);
  }

  ///GET TOKEN DETAIL
  Future<void> getToken(ModelToken token) async {
    token.balanceToken = await Web3Utils().getBalanceOfToken(
      ofAddress: walletAddress,
      tokenAddress: token.tokenAddress,
    );
    //token.exchangeRate = await
    _tokenSubject.sink.add(token);
  }
}
