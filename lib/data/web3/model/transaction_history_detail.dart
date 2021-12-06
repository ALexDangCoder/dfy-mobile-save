class TransactionHistoryDetail {
  double? amount = 0;
  double? gasFee = 0;
  String? time = DateTime.now().toString();
  String? txhId= '';
  String? from= '';
  String? to= '';
  int? nonce= 0;

  TransactionHistoryDetail(
    this.amount,
    this.gasFee,
    this.time,
    this.txhId,
    this.from,
    this.to,
    this.nonce,
  );
  TransactionHistoryDetail.init();
}
