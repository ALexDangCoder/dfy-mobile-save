import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/cool_drop_down/cool_drop_down.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    Key? key,
    required this.listValue,
    required this.onChange, required this.index,
  }) : super(key: key);
  final List<Map<String, String>> listValue;
  final Function(Map<String, String>) onChange;
  final int index;

  @override
  Widget build(BuildContext context) {
    return CoolDropdown(
      key: UniqueKey(),
      isAnimation: false,
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
      defaultValue: listValue[index],
      gap: 10.h,
      resultIcon: Image.asset(ImageAssets.ic_expanded),
      isTriangle: false,
      dropdownHeight: 113.h,
      dropdownItemHeight: 54.h,
      dropdownWidth: 85.w,
      onChange: (value) {
        onChange(value);
      },
      dropdownItemBottomGap: 0,
      dropdownItemTopGap: 0,
      dropdownList: listValue,
    );
  }
}
