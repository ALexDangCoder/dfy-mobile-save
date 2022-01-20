class WalletAddressModel {
  int? userId;
  String? email;
  String? walletAddress;
  int? reputationBorrower;
  int? reputationLender;
  bool? isActive;
  int? createAt;

  WalletAddressModel({
    this.userId,
    this.email,
    this.walletAddress,
    this.reputationBorrower,
    this.reputationLender,
    this.isActive,
    this.createAt,
  });
}
