import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextType {
  RICH_BLUE,
  RICH_WHITE,
  NORMAL,
}

Row buildRow({
  required String title,
  required String detail,
  required TextType type,
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
