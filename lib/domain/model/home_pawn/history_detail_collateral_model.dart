class HistoryCollateralModel {
  int? id;
  String? symbol;
  double? amount;
  String? txnHash;
  int? createdAt;
  int? status;

  HistoryCollateralModel({
    this.id,
    this.symbol,
    this.amount,
    this.txnHash,
    this.createdAt,
    this.status,
  });
}
