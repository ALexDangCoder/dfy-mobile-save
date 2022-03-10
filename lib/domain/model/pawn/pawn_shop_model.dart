import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';

class PawnShopModelMy {
  int? id;
  String? name;
  int? availableLoanPackage;
  double? interest;
  int? reputation;
  String? avatar;
  double? totalValue;
  bool? isKYC;
  int? userId;
  List<TokenModelPawn>? collateralAccepted;
  List<TokenModelPawn>? loanToken;

  PawnShopModelMy({
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
