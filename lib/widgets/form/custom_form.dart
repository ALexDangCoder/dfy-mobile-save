import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    Key? key,
    required this.textValue,
    required this.hintText,
    this.prefix,
    this.suffix,
    required this.inputType,
  }) : super(key: key);
  final Function(String value) textValue;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        onChanged: (value) {
          textValue(value);
        },
        keyboardType: inputType,
        textAlignVertical: TextAlignVertical.center,
        cursorColor: AppTheme.getInstance().textThemeColor(),
        style: textNormal(
          AppTheme.getInstance().textThemeColor(),
          16.sp,
        ),
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
          fillColor: AppTheme.getInstance().itemBtsColors(),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: AppTheme.getInstance().itemBtsColors(),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: AppTheme.getInstance().itemBtsColors(),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.r),
            borderSide: BorderSide(
              color: AppTheme.getInstance().itemBtsColors(),
            ),
          ),
          hintText: hintText,
          hintStyle: textNormal(
            AppTheme.getInstance().disableColor(),
            16.sp,
          ),
          suffixIcon: suffix,
          prefixIcon: prefix,
        ),
      ),
    );
  }
}
