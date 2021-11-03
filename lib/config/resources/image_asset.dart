import 'package:Dfy/config/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  ///Svg path

  static const String icTabWalletSelected =
      '$baseImg/ic_wallet_tab_selected.svg';
  static const String icTabWalletUnSelected =
      '$baseImg/ic_wallet_tab_unselect.svg';

  static const String icTabPawnSelected = '$baseImg/ic_tab_pawn_selected.svg';
  static const String icTabPawnUnselected =
      '$baseImg/ic_tab_pawn_unselected.svg';

  static const String icTabMarketPlaceSelected =
      '$baseImg/ic_tab_market_place_select.svg';
  static const String icTabMarketPlaceUnselected =
      '$baseImg/ic_tab_market_place_unselect.svg';

  static const String icTabStakingSelected =
      '$baseImg/ic_tab_staking_selected.svg';
  static const String icTabStakingUnselected =
      '$baseImg/ic_tab_staking_unselected.svg';

  static SvgPicture svgAssets(
    String name, {
    Color? color,
    double? width,
    double? height,
    BoxFit? fit,
    BlendMode? blendMode,
  }) {
    final size = _svgImageSize[name];
    var w = width;
    var h = height;
    if (size != null) {
      w = width ?? size[0];
      h = height ?? size[1];
    }
    return SvgPicture.asset(
      name,
      colorBlendMode: blendMode ?? BlendMode.srcIn,
      color: color,
      width: w,
      height: h,
      fit: fit ?? BoxFit.none,
    );
  }

  static const Map<String, List<double>> _svgImageSize = {
    icTabWalletSelected: [28, 28],
    icTabWalletUnSelected: [28, 28],
    icTabPawnSelected: [28, 28],
    icTabPawnUnselected: [28, 28],
    icTabMarketPlaceSelected: [28, 28],
    icTabMarketPlaceUnselected: [28, 28],
    icTabStakingSelected: [28, 28],
    icTabStakingUnselected: [28, 28],
  };
}
