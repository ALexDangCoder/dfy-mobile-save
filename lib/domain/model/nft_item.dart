import 'package:Dfy/utils/constants/app_constants.dart';

class NftItem {
  final String name;
  final String image;
  final double price;
  final MarketType? marketType;
  final TypeNFT? typeNFT;
  final TypeImage? typeImage;
  final String? marketId;

  NftItem({
    required this.name,
    required this.image,
    required this.price,
    this.marketType,
    this.typeNFT,
    this.typeImage,
    this.marketId,
  });
}
