import 'package:Dfy/domain/model/home_pawn/pawn_shop_model.dart';

class TopRateLenderModel {
  int? id;
  int? positionItem;
  String? createdAt;
  String? updatedAt;
  bool? isDeleted;
  PawnShopModel? pawnShop;

  TopRateLenderModel({
    this.id,
    this.positionItem,
    this.createdAt,
    this.updatedAt,
    this.isDeleted,
    this.pawnShop,
  });
}
