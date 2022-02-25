import 'package:Dfy/domain/model/evaluation_hard_nft.dart';

class MintRequestModel {
  String? id;
  int? status;
  AssetType? assetType;
  double? expectingPrice;
  String? name;
  String? expectingPriceSymbol;
  int? createAt;
  String? urlToken;

  MintRequestModel({
    this.id,
    this.status,
    this.assetType,
    this.expectingPrice,
    this.name,
    this.expectingPriceSymbol,
    this.createAt,
    this.urlToken,
  });
}
