import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    Key? key,
    required this.textValue,
    required this.hintText,
    this.prefix,
    this.suffix,
    this.isSelectNumPrefix,
    required this.inputType,
    this.formatter,
  }) : super(key: key);
  final Function(String value) textValue;
  final String hintText;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? inputType;
  final bool? isSelectNumPrefix;
  final List<TextInputFormatter>? formatter;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextFormField(
        onChanged: (value) {
          textValue(value);
        },
        inputFormatters: formatter,
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
            borderRadius: isSelectNumPrefix ?? false
                ? BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  )
                : BorderRadius.circular(20.r),
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
