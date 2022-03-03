class PersonalLending {
  String? address;
  String? associatedAddress;
  String? avatar;
  int? completedContracts;
  String? coverImage;
  int? createdAt;
  String? description;
  String? email;
  int? id;
  bool? isDeleted;
  bool? isFeaturedPawnshop;
  bool? isKYC;
  bool? isTrustedLender;
  num? maxInterestRate;
  num? minInterestRate;
  String? name;
  List<P2PLenderPackages>? p2PLenderPackages;
  String? phoneNumber;
  String? rank;
  int? reputation;
  double? totalLoanValue;
  int? type;
  int? updatedAt;
  int? userId;

  PersonalLending({
    this.address,
    this.associatedAddress,
    this.avatar,
    this.completedContracts,
    this.coverImage,
    this.createdAt,
    this.description,
    this.email,
    this.id,
    this.isDeleted,
    this.isFeaturedPawnshop,
    this.isKYC,
    this.isTrustedLender,
    this.maxInterestRate,
    this.minInterestRate,
    this.name,
    this.p2PLenderPackages,
    this.phoneNumber,
    this.rank,
    this.reputation,
    this.totalLoanValue,
    this.type,
    this.updatedAt,
    this.userId,
  });
}

class P2PLenderPackages {
  List<AcceptableAssetsAsCollateral>? acceptableAssetsAsCollateral;

  P2PLenderPackages({this.acceptableAssetsAsCollateral});
}

class AcceptableAssetsAsCollateral {
  String? address;
  String? symbol;

  AcceptableAssetsAsCollateral({this.address, this.symbol});
}
