import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/cool_drop_down/cool_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigDropDown extends StatelessWidget {
  const BigDropDown({
    Key? key,
    required this.listValue,
    required this.textValue, required this.index,
  }) : super(key: key);
  final List<Map<String, dynamic>> listValue;
  final Function(Map<String,dynamic> value) textValue;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Center(
        child: CoolDropdown(
          key: key,
          resultTS: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w400,
          ),
          unselectedItemTS: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w400,
          ),
          selectedItemTS: textNormalCustom(
            AppTheme.getInstance().textThemeColor(),
            16,
            FontWeight.w400,
          ),
          dropdownItemReverse: true,
          dropdownBD: BoxDecoration(
            color: AppTheme.getInstance().colorTextReset(),
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          resultIconLeftGap: 0,
          resultMainAxis: MainAxisAlignment.center,
          dropdownItemMainAxis: MainAxisAlignment.center,
          resultBD: BoxDecoration(
            color: AppTheme.getInstance().itemBtsColors(),
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
          ),
          selectedItemBD: const BoxDecoration(
            color: Colors.transparent,
          ),
          defaultValue: listValue[index],
          gap: 10.h,
          resultIcon: Image.asset(ImageAssets.ic_expanded),
          isTriangle: false,
          dropdownHeight: 113.h,
          dropdownItemHeight: 54.h,
          dropdownItemAlign: Alignment.center,
          resultWidth: 340.w,
          dropdownWidth: 320.w,
          dropdownPadding: EdgeInsets.symmetric(horizontal: 16.w),
          resultAlign: Alignment.center,
          onChange: (value) {
            textValue(value);
          },
          isAnimation: false,
          dropdownItemBottomGap: 0,
          dropdownItemTopGap: 0,
          dropdownList: listValue,
        ),
      ),
    );
  }
}
//0x20f1dE452e9057fe863b99d33CF82DBeE0C45B14