class TransactionHistoryDetail {
  String? amount = '0';
  String? status = 'fail';
  String? gasFee = '0';
  String? time = DateTime.now().toString();
  String? txhId = '';
  String? from = '';
  String? to = '';
  String? nonce = '0';
  String? walletAddress = '';
  String? tokenAddress = '';
  String? name = 'Transaction Interaction';

  TransactionHistoryDetail(
      {this.amount,
      this.status,
      this.gasFee,
      this.time,
      this.txhId,
      this.from,
      this.to,
      this.nonce,
      this.walletAddress,
      this.tokenAddress,
      this.name});

  TransactionHistoryDetail.init();
}
