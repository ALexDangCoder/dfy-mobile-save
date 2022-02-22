import 'dart:convert';

class BcTxnHashModel {
  String? bc_txn_hash;

  BcTxnHashModel({this.bc_txn_hash});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['bc_txn_hash'] = this.bc_txn_hash;
    return data;
  }
}