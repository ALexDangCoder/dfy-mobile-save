import 'package:Dfy/domain/model/home_pawn/crypto_asset_model.dart';
import 'package:Dfy/domain/model/home_pawn/pawn_shop_model.dart';

class OfficialPawnItemModel {
  int? id;
  CryptoAssetModel? cryptoAsset;
  PawnShopModel? pawnShop;
  int? positionItem;
  String? updatedAt;
  String? imageCryptoAsset;

  OfficialPawnItemModel({
    this.id,
    this.cryptoAsset,
    this.pawnShop,
    this.positionItem,
    this.updatedAt,
    this.imageCryptoAsset,
  });
}
