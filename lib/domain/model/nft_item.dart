import 'package:Dfy/presentation/market_place/ui/maket_place_screen.dart';

class NftItem {
  final String name;
  final String image;
  final double price;
  final TypePropertiesNFT? propertiesNFT;
  final TypeHotAuction? hotAuction;
  final TypeNFT? typeNFT;
  final TypeImage? typeImage;

  NftItem({
    required this.name,
    required this.image,
    required this.price,
    this.propertiesNFT,
    this.hotAuction,
    this.typeNFT,
    this.typeImage,
  });
}
