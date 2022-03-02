import 'package:Dfy/domain/model/home_pawn/pawn_shop_package_model.dart';

class TopSalePawnShopItemModel {
  int? id;
  int? signedContract;
  int? positionItem;
  String? updatedAt;
  PawnShopPackageModel? pawnShopPackage;

  TopSalePawnShopItemModel({
    this.id,
    this.signedContract,
    this.positionItem,
    this.updatedAt,
    this.pawnShopPackage,
  });
}
