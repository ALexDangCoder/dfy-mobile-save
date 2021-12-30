import 'package:Dfy/utils/constants/app_constants.dart';

class NftMarket {
  final String nftId;
  final String collectionId;
  final String name;
  final String image;
  final String backGround;
  final double price;
  final String tokenBuyOut;
  final double? reservePrice;
  final double? buyOutPrice;
  final MarketType marketType;
  final TypeNFT typeNFT;
  final TypeImage typeImage;
  final int? startTime = 0;
  final int? endTime = 0;
  final int? numberOfCopies;
  final int? totalCopies;

  NftMarket({
    required this.nftId,
    required this.collectionId,
    required this.backGround,
    required this.tokenBuyOut,
    required this.name,
    required this.image,
    required this.price,
    required this.marketType,
    required this.typeNFT,
    required this.typeImage,
    this.reservePrice,
    this.buyOutPrice,
    this.numberOfCopies,
    this.totalCopies,
  });
}
