class ResultCreateNewModel {
  int? userId;
  String? txnId;
  int? id;
  String? walletAddress;
  double? amount;
  int? expectedLoanDurationTime;
  int? expectedLoanDurationType;
  String? description;
  int? status;

  ResultCreateNewModel({
    this.userId,
    this.txnId,
    this.id,
    this.walletAddress,
    this.amount,
    this.expectedLoanDurationTime,
    this.expectedLoanDurationType,
    this.description,
    this.status,
  });
}
