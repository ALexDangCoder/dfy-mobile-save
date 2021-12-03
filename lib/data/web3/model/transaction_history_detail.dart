class TransactionHistoryDetail {
  double? amount;
  double? gasFee;
  String? time;
  String? txhId;
  String? from;
  String? to;
  int? nonce;

  TransactionHistoryDetail(
    this.amount,
    this.gasFee,
    this.time,
    this.txhId,
    this.from,
    this.to,
    this.nonce,
  );
}
