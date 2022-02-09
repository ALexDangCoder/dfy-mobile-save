import 'package:Dfy/data/result/result.dart';
import 'package:Dfy/data/web3/web3_utils.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/detail_history_nft.dart';
import 'package:Dfy/domain/model/model_token.dart';
import 'package:Dfy/domain/model/token_price_model.dart';
import 'package:Dfy/domain/repository/token_repository.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

class TokenDetailBloc {
  final String walletAddress;
  final Web3Utils _web3client = Web3Utils();
  final TokenRepository _tokenRepository = Get.find();

  TokenDetailBloc({
    required this.walletAddress,
  });

  int minLen = 4;
  List<DetailHistoryTransaction> totalTransactionList = [];
  List<DetailHistoryTransaction> currentTransactionList = [];

  final BehaviorSubject<List<DetailHistoryTransaction>>
      _transactionListSubject = BehaviorSubject();

  Stream<List<DetailHistoryTransaction>> get transactionListStream =>
      _transactionListSubject.stream;

  final BehaviorSubject<bool> _showMoreSubject = BehaviorSubject();

  Stream<bool> get showMoreStream => _showMoreSubject.stream;

  final BehaviorSubject<bool> _showLoadingSubject = BehaviorSubject();

  Stream<bool> get showLoadingStream => _showLoadingSubject.stream;

  final BehaviorSubject<DetailHistoryTransaction>
      _transactionHistoryDetailSubject = BehaviorSubject();

  Stream<DetailHistoryTransaction> get transactionHistoryStream =>
      _transactionHistoryDetailSubject.stream;

  final BehaviorSubject<ModelToken> _tokenSubject = BehaviorSubject();

  Stream<ModelToken> get tokenStream => _tokenSubject.stream;

  ///Get functions
  ///Get list Transaction and detail Transaction
  Future<void> getTransaction({
    required String walletAddress,
    required String tokenAddress,
  }) async {
    final List<DetailHistoryTransaction> listDetailTransaction = [];
    final transactionHistory = await PrefsService.getHistoryTransaction();
    if (transactionHistory.isNotEmpty) {
      transactionFromJson(transactionHistory).forEach(
        (element) {
          if (element.walletAddress == walletAddress &&
              element.tokenAddress == tokenAddress) {
            listDetailTransaction.add(element);
          }
        },
      );
    }
    totalTransactionList = listDetailTransaction;
    currentTransactionList.clear();
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
        await _tokenRepository.getListPriceToken(token.nameShortToken);
    result.when(
      success: (res) {
        token.exchangeRate = res.first.price ?? 0;
      },
      error: (error) {},
    );
    _tokenSubject.sink.add(token);
  }
}
