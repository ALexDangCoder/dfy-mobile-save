import 'package:Dfy/domain/model/nft_market_place.dart';

class NftsCollateralPawnModel {
  int? id;
  int? positionItem;
  String? updatedAt;
  NftMarket? nftModel;

  NftsCollateralPawnModel(
    this.id,
    this.positionItem,
    this.updatedAt,
    this.nftModel,
  );
}
