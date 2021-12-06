import 'package:Dfy/data/web3/model/transaction.dart';
import 'package:Dfy/data/web3/model/transaction_history_detail.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/token_model.dart';
import 'package:Dfy/presentation/bts_nft_detail/ui/detail_transition.dart';
import 'package:rxdart/rxdart.dart';

class TokenDetailBloc {
  final ModelToken modelToken;
  final String walletAddress;
  final Web3Utils _client = Web3Utils();

  TokenDetailBloc({
    required this.modelToken,
    required this.walletAddress,
  });

  int minLen = 4;
  List<TransactionHistory> totalTransactionList = [];
  List<TransactionHistory> currentTransactionList = [];

  final BehaviorSubject<List<TransactionHistory>> _transactionListSubject =
      BehaviorSubject();

  final BehaviorSubject<bool> _showMoreSubject = BehaviorSubject();

  final BehaviorSubject<bool> _isShowTransactionSubmit =
      BehaviorSubject<bool>.seeded(true);

  Stream<List<TransactionHistory>> get transactionListStream =>
      _transactionListSubject.stream;

  Stream<bool> get showMoreStream => _showMoreSubject.stream;

  Stream<bool> get isShowTransactionSubmitStream =>
      _isShowTransactionSubmit.stream;

  final BehaviorSubject<bool> _showLoadingSubject = BehaviorSubject();

  Stream<bool> get showLoadingStream => _showLoadingSubject.stream;

  final BehaviorSubject<TransactionHistoryDetail>
      _transactionHistoryDetailSubject = BehaviorSubject();

  Stream<TransactionHistoryDetail> get transactionHistoryStream =>
      _transactionHistoryDetailSubject.stream;

  ///Get functions
  Future<TransactionHistoryDetail> getTransaction({
    required String txhId,
  }) async {
    final result = await _client.getHistoryDetail(txhId: txhId);
    return result;
  }

  Future<void> getHistory() async {
    final result = await _client.getTransactionHistory(
      ofAddress: walletAddress,
      tokenAddress: modelToken.tokenAddress,
    );
    totalTransactionList = result;
    checkData();
  }

  ///ShowTransactionHistory
  void checkData() {
    if (totalTransactionList.length <= minLen) {
      _transactionListSubject.sink.add(totalTransactionList);
      hideShowMore();
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
      hideShowMore();
    }
    _transactionListSubject.sink.add(currentTransactionList);
  }

  void hideShowMore() {
    _showMoreSubject.sink.add(false);
  }

  ///showLoading
  Future<void> checkShowLoading() async {
    _showLoadingSubject.sink.add(true);
    await Future.delayed(const Duration(seconds: 2));
    _showLoadingSubject.sink.add(false);
  }

  ///GetTokenDetail
  Future<void> getBalance(String _tokenAddress) async {
    modelToken.balanceToken = await Web3Utils().getBalanceOfToken(
      ofAddress: walletAddress,
      tokenAddress: _tokenAddress,
    );
  }
}
