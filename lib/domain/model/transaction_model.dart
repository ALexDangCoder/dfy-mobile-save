import 'dart:typed_data';

class TransactionModel {
  Uint8List signedTransaction;
  bool isSuccess;

  TransactionModel(
    this.signedTransaction,
    this.isSuccess,
  );

  TransactionModel.fromJson(dynamic json)
      : isSuccess = json['isSuccess'],
        signedTransaction = json['signedTransaction'];
}
