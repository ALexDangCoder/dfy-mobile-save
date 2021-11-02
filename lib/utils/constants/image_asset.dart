import 'package:Dfy/config/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  ///Svg path
  static const String icBack = '$baseImg/ic_back.svg';
  static const String icMenu = '$baseImg/ic_menu.svg';
  static const String back = '$baseImg/back.png';
  static const String security = '$baseImg/security.png';
  static const String lock = '$baseImg/Lock.png';
  static const String expand = '$baseImg/expanded.png';
  static const String key = '$baseImg/key.png';
  static const String show = '$baseImg/Show.png';
  static const String hide = '$baseImg/Hide.png';

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
    icMenu: [18, 16],
    icBack: [6, 12.25],
  };
}
