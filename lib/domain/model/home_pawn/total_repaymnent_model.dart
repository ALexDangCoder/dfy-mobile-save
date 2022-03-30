class TotalRepaymentModel {
  String? symbolLoan;
  double? totalLoan;
  String? symbolInterest;
  double? totalInterest;
  String? symbolPenalty;
  double? totalPenalty;

  TotalRepaymentModel(
    this.symbolLoan,
    this.totalLoan,
    this.symbolInterest,
    this.totalInterest,
    this.symbolPenalty,
    this.totalPenalty,
  );

  TotalRepaymentModel.name({
    this.symbolLoan,
  });
}
