class OTPModel {
  //TODO: CHƯA BIẾT RESPONSE CỦA API
  String? transactionId;
  int? expiredSeconds;
  int? failedCount;
  int? failedLimit;
  int? txFailedCount;
  int? txFailedLimit;

  OTPModel({
    this.transactionId,
    this.expiredSeconds,
    this.failedCount,
    this.failedLimit,
    this.txFailedCount,
    this.txFailedLimit,
  });
}
