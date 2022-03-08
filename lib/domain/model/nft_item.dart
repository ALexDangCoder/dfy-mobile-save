import 'package:Dfy/utils/constants/app_constants.dart';

class NftItem {
  final String name;
  final String image;
  final double price;
  final MarketType? marketType;
  final TypeNFT? typeNFT;
  final TypeImage? typeImage;
  final String? marketId;
  final int? type;
  final int? pawnId;
  final String? nftId;
  final String? coverCidIfVid;

  NftItem({
    required this.name,
    required this.image,
    required this.price,
    this.marketType,
    this.typeNFT,
    this.typeImage,
    this.marketId,
    this.pawnId,
    this.type,
    this.coverCidIfVid,
    this.nftId,
  });
}
