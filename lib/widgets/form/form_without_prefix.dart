import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeFormWithoutPrefix {
  DROP_DOWN,
  TEXT,
  IMAGE_FT_TEXT,
  DROP_DOWN_WITH_TEXT,
  IMAGE,
  NONE,
}

class FormWithOutPrefix extends StatelessWidget {
  const FormWithOutPrefix({
    Key? key,
    required this.hintText,
    required this.typeForm,
    required this.cubit,
    required this.txtController,
    this.imageAsset,
    this.quantityOfAll,
    required this.isTokenOrQuantity,
    this.nameToken, required this.textValue, this.formatters,
  }) : super(key: key);
  final String hintText;
  final TypeFormWithoutPrefix typeForm;
  final dynamic cubit;
  final TextEditingController txtController;
  final String? imageAsset;
  final int? quantityOfAll;
  final String? nameToken;
  final bool isTokenOrQuantity;
  final Function(String value) textValue;
  final List<TextInputFormatter>? formatters;

  @override
  Widget build(BuildContext context) {
    if (typeForm == TypeFormWithoutPrefix.IMAGE_FT_TEXT) {
      return Container(
        // width: 343.w,
        height: 64.h,
        padding: EdgeInsets.only(left: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: Center(
          child: TextFormField(
            onChanged: (value){
              textValue(value);
            },
            inputFormatters: formatters,
            keyboardType: TextInputType.number,
            textAlignVertical: TextAlignVertical.center,
            cursorColor: AppTheme.getInstance().textThemeColor(),
            controller: txtController,
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
              suffixIcon: Padding(
                padding: EdgeInsets.only(right: 16.w),
                child: SizedBox(
                  height: 20.h,
                  width: 78.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (isTokenOrQuantity)
                        Text(
                          '$nameToken',
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            16.sp,
                            FontWeight.w400,
                          ),
                        )
                      else
                        Text(
                          '${S.current.of_all} $quantityOfAll',
                          style: textNormalCustom(
                            AppTheme.getInstance().textThemeColor(),
                            16.sp,
                            FontWeight.w400,
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else if (typeForm == TypeFormWithoutPrefix.TEXT) {
      return Container(
        width: 343.w,
        height: 64.h,
        padding: EdgeInsets.only(
          left: 12.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: Center(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            cursorColor: Colors.white,
            controller: txtController,
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
              suffixIcon: Container(
                padding: EdgeInsets.only(top: 15.h),
                child: Text(
                  '${S.current.of_all} $quantityOfAll',
                  style: textNormalCustom(
                    AppTheme.getInstance().textThemeColor(),
                    16.sp,
                    FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else if (typeForm == TypeFormWithoutPrefix.IMAGE) {
      return Container(
        width: 343.w,
        height: 64.h,
        padding: EdgeInsets.only(
          left: 12.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: Center(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            cursorColor: AppTheme.getInstance().textThemeColor(),
            controller: txtController,
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
              suffixIcon: ImageIcon(
                AssetImage(imageAsset ?? ''),
                color: AppTheme.getInstance().textThemeColor(),
              ),
            ),
          ),
        ),
      );
    } else if (typeForm == TypeFormWithoutPrefix.NONE) {
      return Container(
        width: 343.w,
        height: 64.h,
        padding: EdgeInsets.only(
          left: 12.w,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          color: AppTheme.getInstance().itemBtsColors(),
        ),
        child: Center(
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            cursorColor: AppTheme.getInstance().textThemeColor(),
            controller: txtController,
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
              suffixIcon: const Text(''),
            ),
          ),
        ),
      );
    } else {
      // TODO handle UI WHEN SHOW DROPDOWN AND DROWDOWN WITH MONTH
      return const Text('CHUA CO CHUC NANG');
    }
  }
}
