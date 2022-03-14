import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormDropDownWidget extends StatelessWidget {
  const FormDropDownWidget({
    Key? key,
    required this.initValue,
    required this.listDropDown,
    required this.onChange,
    required this.widthDropDown,
    required this.heightDropDown,
  }) : super(key: key);
  final List<Map<String, dynamic>> listDropDown;
  final Map<String, dynamic> initValue;
  final Function(Map<String, dynamic> value) onChange;
  final double widthDropDown;
  final double heightDropDown;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120.w,
      child: Center(
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Positioned(
              child: CoolDropdown(
                dropdownItemGap: 5.h,
                dropdownItemMainAxis: MainAxisAlignment.start,
                resultMainAxis: MainAxisAlignment.start,
                isTriangle: false,
                dropdownList: listDropDown,
                dropdownWidth: widthDropDown,
                dropdownHeight: heightDropDown,
                dropdownPadding: EdgeInsets.only(right: 0.w),
                dropdownItemHeight: 54.h,
                defaultValue: initValue,
                resultIcon: const SizedBox.shrink(),
                dropdownItemReverse: true,
                dropdownBD: BoxDecoration(
                  color: AppTheme.getInstance().selectDialogColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                unselectedItemTS: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16,
                ),
                resultTS: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16,
                ),
                selectedItemBD: BoxDecoration(
                  color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
                ),
                selectedItemTS: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  16,
                ),
                resultBD: BoxDecoration(
                  color: AppTheme.getInstance().backgroundBTSColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                onChange: (value) {
                  onChange(value as Map<String, dynamic>);
                },
              ),
            ),
            Positioned(
              right: 19.15.w,
              // top: -7.h,
              child: SizedBox(
                height: 70.h,
                child: sizedSvgImage(
                  w: 13,
                  h: 13,
                  image: ImageAssets.ic_expand_white_svg,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
