import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FormType { PASS_PHRASE, PASSWORD, PRIVATE_KEY }

class ItemForm extends StatelessWidget {
  const ItemForm({
    Key? key,
    required this.leadPath,
    required this.hint,
    required this.trailingPath,
    required this.formType,
    this.callback,
    required this.isShow,
    required this.controller,
  }) : super(key: key);
  final String leadPath;
  final String hint;
  final String trailingPath;
  final FormType formType;
  final Function()? callback;
  final bool isShow;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    if (formType == FormType.PASS_PHRASE) {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 64.h,
        ),
        child: Container(
          width: 323.w,
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 10.h,
            right: 10.w,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            color: AppTheme.getInstance().itemBtsColors(),
          ),
          child: TextFormField(
            controller: controller,
            style: textNormal(
              Colors.white,
              16.sp,
            ),
            minLines: 1,
            maxLines: 10,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: textNormal(
                Colors.grey,
                16.sp,
              ),
              suffixIcon: InkWell(
                onTap: callback,
                child: ImageIcon(
                  AssetImage(trailingPath),
                  color: const Color(0xffE4AC1A),
                ),
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
    } else if (formType == FormType.PRIVATE_KEY) {
      return Container(
        height: 64.h,
        width: 323.w,
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
          right: 10.w,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isShow,
          style: textNormal(
            Colors.white,
            16.sp,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textNormal(
              Colors.grey,
              16.sp,
            ),
            suffixIcon: InkWell(
              onTap: callback,
              child: ImageIcon(
                AssetImage(trailingPath),
                color: const Color(0xffE4AC1A),
              ),
            ),
            prefixIcon: ImageIcon(
              AssetImage(leadPath),
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
        ),
      );
    } else {
      return Container(
        height: 64.h,
        width: 323.w,
        padding: EdgeInsets.only(
          top: 12.h,
          bottom: 12.h,
        ),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: TextFormField(
          controller: controller,
          obscureText: isShow,
          style: textNormal(
            Colors.white,
            16.sp,
          ),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: textNormal(
              Colors.grey,
              16.sp,
            ),
            suffixIcon: InkWell(
              onTap: callback,
              child: ImageIcon(
                AssetImage(trailingPath),
                color: Colors.grey,
              ),
            ),
            prefixIcon: ImageIcon(
              AssetImage(leadPath),
              color: Colors.white,
            ),
            border: InputBorder.none,
          ),
        ),
      );
    }
  }
}
