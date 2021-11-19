import 'package:Dfy/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TextType {
  RICH,
  NORM,
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
                style: textFieldNFT,
              ),
            ),
          ),
        ),
        if (type == TextType.NORM)
          SizedBox(
            width: 225.w,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                detail,
                style: textValueNFT,
                maxLines: 2,
              ),
            ),
          )
        else
          SizedBox(
            width: 225.w,
            child: RichText(
              maxLines: 1,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: detail,
                    style: richTextValueNFT,
                  ),
                ],
              ),
            ),
          )
      ],
    );
