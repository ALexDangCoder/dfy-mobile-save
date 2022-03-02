class PawnShopModel {
  int? id;
  int? userId;
  String? name;
  int? reputation;
  int? type;
  String? email;
  String? phoneNumber;
  String? address;
  String? description;
  String? walletAddress;

  PawnShopModel(
      {this.id,
      this.userId,
      this.name,
      this.reputation,
      this.type,
      this.email,
      this.phoneNumber,
      this.address,
      this.description,
      this.walletAddress});
}
