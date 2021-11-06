import 'package:Dfy/config/resources/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssets {
  ///Svg path
  ///Png path
  static const String icBack = '$baseImg/ic_back.svg';
  static const String icMenu = '$baseImg/ic_menu.svg';
  static const String back = '$baseImg/back.png';
  static const String security = '$baseImg/security.png';
  static const String lock = '$baseImg/Lock.png';
  static const String expand = '$baseImg/expanded.png';
  static const String key = '$baseImg/key.png';
  static const String show = '$baseImg/Show.png';
  static const String hide = '$baseImg/Hide.png';
  static const String addsWallet = '$baseImg/addsWallet.png';
  static const String backArrow = '$baseImg/back_arrow.png';
  static const String centered = '$baseImg/Centered.png';
  static const String code = '$baseImg/Code.png';
  static const String expanded = '$baseImg/expanded.png';
  static const String faceID = '$baseImg/face_id_icon.png';
  static const String ic_finger = '$baseImg/finger_con.png';
  static const String frameGreen = '$baseImg/Framegreen.png';
  static const String group = '$baseImg/Group.png';
  static const String icAdd = '$baseImg/ic_add.png';
  static const String icAddress = '$baseImg/ic_address.png';
  static const String icCircle = '$baseImg/ic_circle.png';
  static const String icClose = '$baseImg/ic_close.png';
  static const String icCopy = '$baseImg/ic_copy.png';
  static const String icEdit = '$baseImg/ic_edit.png';
  static const String icFace = '$baseImg/ic_faceid.png';
  static const String icFrame = '$baseImg/ic_frame.png';
  static const String icImport = '$baseImg/ic_import.png';
  static const String icKey = '$baseImg/ic_key.png';
  static const String icLineDown = '$baseImg/ic_line_down.png';
  static const String icLineRight = '$baseImg/ic_line_right.png';
  static const String icOut = '$baseImg/ic_out.png';
  static const String icPassword = '$baseImg/ic_password.png';
  static const String icTabMarketSelect =
      '$baseImg/ic_tab_market_place_select.svg.svg';
  static const String icTabMarketUnselect =
      '$baseImg/ic_tab_market_place_unselect.svg';
  static const String icTabPawnS = '$baseImg/ic_tab_pawn_selected.svg';
  static const String icTabPawnU = '$baseImg/ic_tab_pawn_unselected.svg';
  static const String icTabStakingS = '$baseImg/ic_tab_stacking_selected.svg';
  static const String icTabStackingU =
      '$baseImg/ic_tab_stacking_unselected.svg';
  static const String icWallet = '$baseImg/ic_wallet.png';
  static const String icWalletTabS = '$baseImg/ic_wallet_tab_selected.svg';
  static const String icWalletTabU = '$baseImg/ic_wallet_tab_unselected.svg';
  static const String imgEmpty = '$baseImg/img_empty.png';
  static const String imgTabHome = '$baseImg/img_tab_home.png';
  static const String menu = '$baseImg/Menu.png';
  static const String notification = '$baseImg/Notification.png';
  static const String stroke = '$baseImg/Stroke.png';
  static const String symbol = '$baseImg/symbol.png';
  static const String to = '$baseImg/To.png';
  static const String token = '$baseImg/Token.png';
  static const String codeS = '$baseImg/Code.png';
  static const String from = '$baseImg/From.png';

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
