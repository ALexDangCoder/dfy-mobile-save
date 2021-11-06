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
  static const String ic_wallet = '$baseImg/ic_wallet.png';
  static const String ic_copy = '$baseImg/ic_copy.png';
  static const String ic_address = '$baseImg/ic_address.png';
  static const String ic_frame = '$baseImg/ic_frame.png';
  static const String ic_face_id = '$baseImg/ic_faceid.png';
  static const String ic_password = '$baseImg/ic_password.png';
  static const String ic_group = '$baseImg/Group.png';
  static const String add_wallet = '$baseImg/addstwallet.png';
  static const String ic_menu = '$baseImg/Menu.png.png';
  static const String ic_notify = '$baseImg/Notification.png';
  static const String symbol = '$baseImg/symbol.png';
  static const String center = '$baseImg/Centered.png';
  static const String ic_touch = '$baseImg/finger_icon.png';
  static const String ic_out = '$baseImg/ic_out.png';
  static const String ic_close = '$baseImg/ic_close.png';
  static const String img_empty = '$baseImg/img_empty.png';
  static const String paste = '$baseImg/Paste.png';

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
