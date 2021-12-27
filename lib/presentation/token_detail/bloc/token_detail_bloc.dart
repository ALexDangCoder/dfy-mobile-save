import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/model/transaction_history_detail.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/token_price_model.dart';
import 'package:Dfy/domain/repository/price_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class TokenDetailBloc {
  final String walletAddress;
  final Web3Utils _web3client = Web3Utils();
  final PriceRepository _priceRepository = Get.find();

  TokenDetailBloc({
    required this.walletAddress,
  });

  int minLen = 4;
  List<TransactionHistoryDetail> totalTransactionList = [];
  List<TransactionHistoryDetail> currentTransactionList = [];

  final BehaviorSubject<List<TransactionHistoryDetail>>
      _transactionListSubject = BehaviorSubject();

  Stream<List<TransactionHistoryDetail>> get transactionListStream =>
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

  Stream<ModelToken> get tokenStream => _tokenSubject.stream;

  ///Get functions
  ///Get list Transaction and detail Transaction
  Future<void> getTransaction({
    required String walletAddress,
    required String tokenAddress,
  }) async {
    final List<TransactionHistoryDetail> listFromData = [];
    totalTransactionList = listFromData
        .where(
          (element) =>
              element.tokenAddress == tokenAddress &&
              element.walletAddress == walletAddress,
        )
        .toList();
    //todo Clear Fake Data
    totalTransactionList = [
      TransactionHistoryDetail.init(),
      TransactionHistoryDetail.init(),
      TransactionHistoryDetail.init(),
      TransactionHistoryDetail.init(),
      TransactionHistoryDetail.init(),
      TransactionHistoryDetail.init(),
      TransactionHistoryDetail.init(),
    ];
    checkData();
  }

  Future<void> getHistory(String _tokenAddress) async {
    // final result = await _web3client.getTransactionHistory(
    //   ofAddress: walletAddress,
    //   tokenAddress: _tokenAddress,
    // );
    // totalTransactionList = result;
    // checkData();
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
  Future<void> checkShowLoading(ModelToken token) async {
    _showLoadingSubject.sink.add(true);
    await Future.delayed(const Duration(seconds: 1));
    await getToken(token: token);
    await getHistory(token.tokenAddress);
    _showLoadingSubject.sink.add(false);
  }

  ///GET TOKEN DETAIL
  Future<void> getToken({required ModelToken token}) async {
    if (token.nameShortToken == 'BNB') {
      token.balanceToken = await _web3client.getBalanceOfBnb(
        ofAddress: walletAddress,
      );
    } else {
      token.balanceToken = await _web3client.getBalanceOfToken(
        ofAddress: walletAddress,
        tokenAddress: token.tokenAddress,
      );
    }
    final Result<List<TokenPrice>> result =
        await _priceRepository.getListPriceToken(token.nameShortToken);
    result.when(
      success: (res) {
        token.exchangeRate = res.first.price ?? 0;
      },
      error: (error) {},
    );
    _tokenSubject.sink.add(token);
  }
}
