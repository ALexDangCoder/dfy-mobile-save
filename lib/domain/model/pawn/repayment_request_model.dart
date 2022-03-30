class RepaymentRequestModel {
  int? id;
  int? startDate;
  int? dueDate;
  int? status;
  bool? isLocked;
  String? borrowerWalletAddress;
  String? lenderWalletAddress;
  double? systemFee;
  double? prepaidFee;
  RepaymentTokenModel? penalty;
  RepaymentTokenModel? interest;
  RepaymentTokenModel? loan;
  int? smartContractType;
  String? txnHash;
  int? paymentDate;
  int? txnId;

  RepaymentRequestModel.name({this.id});

  RepaymentRequestModel(
    this.id,
    this.startDate,
    this.dueDate,
    this.status,
    this.isLocked,
    this.borrowerWalletAddress,
    this.lenderWalletAddress,
    this.systemFee,
    this.prepaidFee,
    this.penalty,
    this.interest,
    this.loan,
    this.smartContractType,
    this.txnHash,
    this.paymentDate,
    this.txnId,
  );
}

class RepaymentTokenModel {
  double? amountPaid;
  double? amount;
  String? symbol;
  String? address;

  RepaymentTokenModel(
    this.amountPaid,
    this.amount,
    this.symbol,
    this.address,
  );
}
