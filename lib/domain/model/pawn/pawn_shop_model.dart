import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';

class PawnShopModel {
  int? id;
  String? name;
  int? availableLoanPackage;
  int? interest;
  int? reputation;
  String? avatar;
  double? totalValue;
  bool? isKYC;
  int? userId;
  List<TokenModelPawn>? collateralAccepted;
  List<TokenModelPawn>? loanToken;

  PawnShopModel({
    this.id,
    this.name,
    this.availableLoanPackage,
    this.interest,
    this.reputation,
    this.avatar,
    this.totalValue,
    this.isKYC,
    this.userId,
    this.collateralAccepted,
    this.loanToken,
  });
}
