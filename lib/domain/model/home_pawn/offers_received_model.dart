import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';

class OffersReceivedModel {
  int? id;
  String? lender;
  int? reputation;
  TokenModelPawn? supplyCurrency;
  int? duration;
  int? durationType;
  int? interestPerYear;
  int? riskDefault;
  int? status;
  int? collateralId;
  int? bcOfferId;
  int? bcCollateralId;
  int? liquidationThreshold;
  int? createdAt;
  String? name;

  OffersReceivedModel({
    this.id,
    this.lender,
    this.reputation,
    this.supplyCurrency,
    this.duration,
    this.durationType,
    this.interestPerYear,
    this.riskDefault,
    this.status,
    this.collateralId,
    this.bcOfferId,
    this.bcCollateralId,
    this.liquidationThreshold,
    this.createdAt,
    this.name,
  });
}
