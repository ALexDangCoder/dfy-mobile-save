import 'package:Dfy/presentation/token_detail/bloc/token_detail_bloc.dart';

class TransactionModel {
  String title = '';
  int amount = 0;
  TransactionStatus status = TransactionStatus.PENDING;
  DateTime time = DateTime.now();
  String txhId = '0xaaa042c0632f4d44c7cea978f22cd02e751a410e';
  String from = '0xaaa042c0632f4d44c7cea978f22cd02e751a410e';
  String to = '0xaaa042c0632f4d44c7cea978f22cd02e751a410e';
  int nonce = 0;
  TransactionType type = TransactionType.RECEIVE;

  TransactionModel({
    required this.title,
    required this.amount,
    required this.status,
    required this.time,
    required this.txhId,
    required this.from,
    required this.to,
    required this.nonce,
    required this.type,
  });

  TransactionModel.init();
}
