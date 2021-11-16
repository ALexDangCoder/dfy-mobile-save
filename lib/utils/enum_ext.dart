import 'package:Dfy/utils/constants/image_asset.dart';

enum EnumTokenType {
  NFT,
  DFY,
  BTC,
  BNB,
}

extension TokenTypeExtension on EnumTokenType {
  String get imageToken {
    switch (this) {
      case EnumTokenType.DFY:
        return ImageAssets.ic_token_dfy_svg;
      case EnumTokenType.BTC:
        return ImageAssets.ic_token_btc_svg;
      case EnumTokenType.BNB:
        return ImageAssets.ic_token_bnb_svg;
      case EnumTokenType.NFT:
        return ImageAssets.ic_token_dfy_svg;
    }
  }
  String get nameToken{
    switch (this) {
      case EnumTokenType.DFY:
        return 'DFY';
      case EnumTokenType.BTC:
        return 'BTC';
      case EnumTokenType.BNB:
        return 'BNB';
      case EnumTokenType.NFT:
        return 'NFT';
    }
  }
}
