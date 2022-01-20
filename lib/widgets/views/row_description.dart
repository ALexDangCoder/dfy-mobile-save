import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum TextType {
  RICH_BLUE,
  RICH_WHITE,
  NORMAL,
}

Row buildRow({
  required String title,
  required String detail,
  required TextType type,
  bool isShowCopy = false,
}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: SizedBox(
            width: 126.w,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                title,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                  14,
                  FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        if (type == TextType.NORMAL) ...[
          SizedBox(
            width: 225.w,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                detail,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  14,
                  FontWeight.w400,
                ),
              ),
            ),
          )
        ] else if (type == TextType.RICH_BLUE && isShowCopy) ...[
          SizedBox(
            width: 225.w,
            child: Row(
              children: [
                RichText(
                  maxLines: 1,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: detail.handleString(),
                        style: richTextBlue,
                      ),
                    ],
                  ),
                ),
                spaceW4,
                InkWell(
                  onTap: () {
                    FlutterClipboard.copy(detail);
                    Fluttertoast.showToast(
                      msg: S.current.copy,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                    );
                  },
                  child: Image.asset(ImageAssets.ic_copy),
                )
              ],
            ),
          ),
        ] else if (type == TextType.RICH_BLUE) ...[
          SizedBox(
            width: 225.w,
            child: RichText(
              maxLines: 1,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: detail,
                    style: richTextBlue,
                  ),
                ],
              ),
            ),
          ),
        ] else
          SizedBox(
            width: 225.w,
            child: RichText(
              maxLines: 1,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: detail,
                    style: richTextWhite,
                  ),
                ],
              ),
            ),
          )
      ],
    );

Widget buildRowCustom({
  required String title,
  required Widget child,
  bool isPadding = true,
  bool isSpace = true,
}) {
  return Padding(
    padding:
        isPadding ? EdgeInsets.symmetric(horizontal: 16.w) : EdgeInsets.zero,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 2,
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: textNormalCustom(
                AppTheme.getInstance().textThemeColor().withOpacity(0.7),
                16,
                FontWeight.w400,
              ),
            ),
          ),
        ),
        Expanded(flex: 3, child: child)
      ],
    ),
  );
}
