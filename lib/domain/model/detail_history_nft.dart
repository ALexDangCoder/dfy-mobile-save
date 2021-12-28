import 'dart:convert';

List<DetailHistoryTransaction> transactionFromJson(String str) =>
    List<DetailHistoryTransaction>.from(json
        .decode(str)
        .map((x) => DetailHistoryTransaction.fromWalletCore(x)));

String transactionToJson(List<DetailHistoryTransaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailHistoryTransaction {
  String? quantity = '';
  String? status = '';
  String? gasFee = '';
  String? dateTime = DateTime.now().toString();
  String? txhID = '';
  String? toAddress = '';
  String? nonce = '';
  String? name = '';
  String? walletAddress = '';
  String? tokenAddress = '';
  String? type = '';

  DetailHistoryTransaction({
    this.quantity,
    this.status,
    this.gasFee,
    this.dateTime,
    this.txhID,
    this.toAddress,
    this.nonce,
    this.name,
    this.walletAddress,
    this.tokenAddress,
    this.type,
  });

  DetailHistoryTransaction.init();

  Map<String, dynamic> toJson() => <String, dynamic>{
        'walletAddress': walletAddress,
        'quantity': quantity,
        'status': status,
        'gasFee': gasFee,
        'dateTime': dateTime,
        'txhID': txhID,
        'toAddress': toAddress,
        'nonce': nonce,
        'name': name,
        'tokenAddress': tokenAddress,
        'type': type,
      };

  DetailHistoryTransaction.fromWalletCore(dynamic json)
      : walletAddress = json['walletAddress'].toString(),
        quantity = json['quantity'].toString(),
        status = json['status'].toString(),
        gasFee = json['gasFee'].toString(),
        dateTime = json['dateTime'].toString(),
        txhID = json['txhID'].toString(),
        toAddress = json['toAddress'].toString(),
        nonce = json['nonce'].toString(),
        name = json['name'].toString(),
        tokenAddress = json['tokenAddress'].toString(),
        type = json['type'].toString();
}
