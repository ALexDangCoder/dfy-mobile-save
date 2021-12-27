import 'dart:convert';

List<DetailHistoryTransaction> transactionFromJson(String str) =>
    List<DetailHistoryTransaction>.from(json
        .decode(str)
        .map((x) => DetailHistoryTransaction.fromWalletCore(x)));

String transactionToJson(List<DetailHistoryTransaction> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailHistoryTransaction {
  final String? quantity;
  final String? status;
  final String? gasFee;
  final String? dateTime;
  final String? txhID;
  final String? toAddress;
  final String? nonce;
  final String? name;
  final String? walletAddress;
  final String? tokenAddress;
  final String? type;

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
