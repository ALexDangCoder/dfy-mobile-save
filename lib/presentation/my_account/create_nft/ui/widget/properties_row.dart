import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget propertyRow() {
  return Container(
    height: 116.h,
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    decoration: BoxDecoration(
      color: AppTheme.getInstance().backgroundBTSColor(),
      borderRadius: BorderRadius.all(
        Radius.circular(20.r),
      ),
    ),
    child: Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              // controller: textController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(256),
              ],
              cursorColor: AppTheme.getInstance().whiteColor(),
              style: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
              onChanged: (value) {
                // onChange(value);
              },
              decoration: InputDecoration(
                hintText: 'Properties',
                hintStyle: textNormal(
                  Colors.white.withOpacity(0.5),
                  16,
                ),
                suffixStyle: textCustom(),
                border: InputBorder.none,
              ),
              // onFieldSubmitted: ,
            ),
          ),
        ),
        line,
        Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TextFormField(
              // controller: textController,
              inputFormatters: [
                LengthLimitingTextInputFormatter(256),
              ],
              cursorColor: AppTheme.getInstance().whiteColor(),
              style: textNormal(
                AppTheme.getInstance().whiteColor(),
                16,
              ),
              onChanged: (value) {
                // onChange(value);
              },
              decoration: InputDecoration(
                hintText: 'Value',
                hintStyle: textNormal(
                  Colors.white.withOpacity(0.5),
                  16,
                ),
                suffixStyle: textCustom(),
                border: InputBorder.none,
              ),
              // onFieldSubmitted: ,
            ),
          ),
        ),
      ],
    ),
  );
}
