import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TokenDropDown extends StatelessWidget {
  const TokenDropDown({
    Key? key,
    required this.listValue,
    required this.textValue,
  }) : super(key: key);
  final List<Map<String, dynamic>> listValue;
  final Function(String value) textValue;

  @override
  Widget build(BuildContext context) {
    return CoolDropdown(
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
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
      ),
      resultBD: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      selectedItemBD: const BoxDecoration(
        color: Colors.transparent,
      ),
      defaultValue: listValue.first,
      gap: 10.h,
      resultIcon: Image.asset(ImageAssets.ic_expanded),
      isTriangle: false,
      dropdownHeight: 113.h,
      dropdownItemHeight: 54.h,
      dropdownWidth: 90.w,
      onChange: (value) {
        textValue(value);
      },
      dropdownItemBottomGap: 0,
      dropdownItemTopGap: 0,
      dropdownList: listValue,
    );
  }
}
