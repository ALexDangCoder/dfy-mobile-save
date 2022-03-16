import 'package:Dfy/domain/model/pawn/personal_lending.dart';

class PawnshopPackage {
  List<AcceptableAssetsAsCollateral>? acceptableAssetsAsCollateral;
  int? id;
  num? interest;
  num? interestMax;
  num? interestMin;
  bool? isFavourite;
  num? loanToValue;
  int? durationQtyType;
  Pawnshop? pawnshop;
  int? type;

  PawnshopPackage({
    this.acceptableAssetsAsCollateral,
    this.id,
    this.interest,
    this.isFavourite,
    this.loanToValue,
    this.durationQtyType,
    this.pawnshop,
    this.type,
    this.interestMax,
    this.interestMin,
  });
}

class Pawnshop {
  String? address;
  String? avatar;
  String? cover;
  String? name;
  int? id;
  int? type;
  int? userId;
  bool? isKYC;
  bool? isTrustedLender;
  int? reputation;

  Pawnshop({
    this.address,
    this.avatar,
    this.cover,
    this.id,
    this.type,
    this.userId,
    this.isKYC,
    this.isTrustedLender,
    this.name,
    this.reputation,
  });
}
