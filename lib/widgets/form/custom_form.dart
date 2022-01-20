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
    required this.suffix,
    required this.inputType,
  }) : super(key: key);
  final Function(String value) textValue;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? inputType;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Center(
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
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: textNormal(
              AppTheme.getInstance().disableColor(),
              16.sp,
            ),
            suffixIcon: suffix,
            prefix: prefix,
          ),
        ),
      ),
    );
  }
}
