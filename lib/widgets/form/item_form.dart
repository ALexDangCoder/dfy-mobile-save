import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemForm extends StatelessWidget {
  const ItemForm(
      {Key? key,
      required this.leadPath,
      required this.hint,
      required this.trailingPath})
      : super(key: key);
  final String leadPath;
  final String hint;
  final String trailingPath;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 323.w,
        maxHeight: 200.h,
        minHeight: 64.h,
      ),
      child: Container(
        width: 323.w,
        height: 64.h,
        padding: EdgeInsets.only(
          top: 14.h,
          bottom: 14.h,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppTheme.getInstance().itemBtsColor(),
        ),
        child: TextFormField(
          //obscureText: true,
          style: textNormal(
            Colors.white,
            16.sp,
          ),
          minLines: 1,
          maxLines: 10,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 2.h),
            filled: true,
            fillColor: Colors.transparent,
            hintText: hint,
            hintStyle: textNormal(
              Colors.grey,
              14.sp,
            ),
            suffixIcon: ImageIcon(
              AssetImage(trailingPath),
              color: Colors.white,
            ),
            prefixIcon: ImageIcon(
              AssetImage(leadPath),
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
