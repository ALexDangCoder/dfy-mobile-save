import 'package:Dfy/config/resources/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemIconText extends StatelessWidget {
  final String icon;
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const ItemIconText({
    Key? key,
    required this.icon,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.w400,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: textNormalCustom(
          null,
          fontSize,
          fontWeight,
        ),
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              margin: EdgeInsets.only(
                right: 10.w,
              ),
              child: Image.asset(
                icon,
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          TextSpan(
            text: text,
          ),
        ],
      ),
    );
  }
}
