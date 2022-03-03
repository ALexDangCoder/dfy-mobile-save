import 'package:Dfy/domain/model/home_pawn/loan_token_model.dart';
import 'package:Dfy/domain/model/home_pawn/pawn_shop_model.dart';

class PawnShopPackageModel {
  int? id;
  String? name;
  PawnShopModel? pawnShop;
  double? allowedLoanMax;
  double? allowedLoanMin;
  int? interestMin;
  int? interestMax;
  int? type;
  int? status;
  LoanTokenModel? loanToken;
  int? interestRate;

  PawnShopPackageModel({
    this.id,
    this.name,
    this.pawnShop,
    this.allowedLoanMax,
    this.allowedLoanMin,
    this.interestMin,
    this.interestMax,
    this.type,
    this.status,
    this.loanToken,
    this.interestRate,
  });
}
