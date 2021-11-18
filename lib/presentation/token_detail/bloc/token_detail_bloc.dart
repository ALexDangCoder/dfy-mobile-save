import 'dart:math' hide log;
import 'package:Dfy/domain/model/transaction.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:rxdart/rxdart.dart';

class TokenDetailBloc {
  static const len_mock_data = 83;
    final List<TransactionModel> mocObject = List.generate(
    len_mock_data,
        (index) =>
        TransactionModel(
          title: S.current.contract_interaction,
          amount: Random().nextInt(9999),
          status: TransactionStatus
              .values[Random().nextInt(TransactionStatus.values.length)],
          time: DateTime.now(),
          txhId: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
          from: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
          to: '0xaaa042c0632f4d44c7cea978f22cd02e751a410e',
          nonce: Random().nextInt(9999),
          type: TransactionType.values[Random().nextInt(
            TransactionType.values.length,)],
        ),
  );
  ///todoClearFakeData

  int dataListLen = 4;
  List<TransactionModel> transactionList = [];

  final BehaviorSubject<List<TransactionModel>> _transactionListSubject =
  BehaviorSubject();

  final BehaviorSubject<bool> _showMoreSubject = BehaviorSubject();

  Stream<List<TransactionModel>> get transactionListStream =>
      _transactionListSubject.stream;

  Stream<bool> get showMoreStream => _showMoreSubject.stream;


  void checkData() {
    if (mocObject.length <= dataListLen) {
      _transactionListSubject.sink.add(mocObject);
      hideShowMore();
    } else {
      transactionList = mocObject.sublist(0, dataListLen);
      _transactionListSubject.sink.add(transactionList);
      _showMoreSubject.sink.add(true);
    }
  }

  void showMore() {
    if (mocObject.length - transactionList.length > 10) {
      transactionList.addAll(
        mocObject.sublist(transactionList.length, transactionList.length + 10),
      );
    } else {
      transactionList = mocObject;
      hideShowMore();
    }
    _transactionListSubject.sink.add(transactionList);
  }

  void hideShowMore() {
    _showMoreSubject.sink.add(false);
  }
}

extension StatusExtension on TransactionStatus {
  String get statusImage {
    switch (this) {
      case TransactionStatus.SUCCESS:
        return ImageAssets.ic_transaction_success_svg;
      case TransactionStatus.FAILED:
        return ImageAssets.ic_transaction_fail_svg;
      case TransactionStatus.PENDING:
        return ImageAssets.ic_transaction_pending_svg;
    }
  }
}

enum TransactionStatus {
  SUCCESS,
  FAILED,
  PENDING,
}
enum TransactionType {
  SEND,
  RECEIVE,
}
