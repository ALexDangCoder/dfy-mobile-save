class RepaymentStatsModel {
  double? totalLoan;
  double? totalPaid;
  double? totalUnpaid;

  RepaymentStatsModel(
    this.totalLoan,
    this.totalPaid,
    this.totalUnpaid,
  );

  RepaymentStatsModel.name({
    this.totalLoan,
    this.totalPaid,
    this.totalUnpaid,
  });
}
