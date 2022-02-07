import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TYPE_FORM_DROPDOWN {
  CONDITION,
  COUNTRY,
  CITY,
  PHONE,
  PRICE,
}

List<Map<String, String>> cities = [
  {'label': 'Vinh'},
  {'label': 'Hanoi'},
  {'label': 'Nam Dinh'},
  {'label': 'asd'},
  {'label': 'Vinh1'},
  {'label': 'Hanoi2'},
  {'label': 'asd7'},
  {'label': 'sd8'},
];

class Token {
  final String shortName;
  final String image;

  Token(this.shortName, this.image);
}

List<Token> tokens = [
  Token(
    'Dfy',
    ImageAssets.ic_dfy,
  ),
  Token(
    'NFY',
    ImageAssets.ic_dfy,
  ),
  Token(
    'lgf',
    ImageAssets.ic_dfy,
  ),
  Token(
    'fuk',
    ImageAssets.ic_dfy,
  ),
  Token(
    '123',
    ImageAssets.ic_dfy,
  ),
  Token(
    '312',
    ImageAssets.ic_dfy,
  ),
  Token(
    '1',
    ImageAssets.ic_dfy,
  ),
  Token(
    '2',
    ImageAssets.ic_dfy,
  ),
  Token(
    '3',
    ImageAssets.ic_dfy,
  ),
  Token(
    '66',
    ImageAssets.ic_dfy,
  )
];

List<Map<String, dynamic>> tokensMap = [
  {
    'label': '${tokens[0].shortName}',
    'icon': SizedBox(
      width: 20.w,
      height: 20.h,
      child: Image.asset(tokens[0].image),
    ),
  },
  {
    'label': '${tokens[1].shortName}',
    'icon': SizedBox(
      width: 20.w,
      height: 20.h,
      child: Image.asset(tokens[1].image),
    ),
  },
  {
    'label': '${tokens[2].shortName}',
    'icon': SizedBox(
      width: 20.w,
      height: 20.h,
      child: Image.asset(tokens[2].image),
    ),
  }
];

List<Map<String, String>> phones = [
  {'label': '+84'},
  {'label': '+29'},
  {'label': '+39'},
  {'label': '+65'},
  {'label': '+66'},
  {'label': '+12'},
  {'label': '+32'},
];

class FormDropDown extends StatelessWidget {
  const FormDropDown({
    Key? key,
    required this.typeDrop,
  }) : super(key: key);
  final TYPE_FORM_DROPDOWN typeDrop;

  @override
  Widget build(BuildContext context) {
    if (typeDrop == TYPE_FORM_DROPDOWN.CITY ||
        typeDrop == TYPE_FORM_DROPDOWN.CONDITION ||
        typeDrop == TYPE_FORM_DROPDOWN.COUNTRY) {
      return Stack(
        children: [
          CoolDropdown(
            // gap: 8.h,
            dropdownItemMainAxis: MainAxisAlignment.start,
            resultMainAxis: MainAxisAlignment.start,
            dropdownList: cities,
            onChange: (value) {
              print(value['label']);
            },
            dropdownItemHeight: 54.h,
            dropdownHeight: cities.length < 4 ? (54 * cities.length).h : 232.h,
            dropdownWidth: 343.w,
            resultAlign: Alignment.centerRight,
            resultWidth: 343.w,
            resultHeight: 64.h,
            dropdownPadding: EdgeInsets.only(right: 11.w),
            dropdownBD: BoxDecoration(
              color: AppTheme.getInstance().selectDialogColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            resultBD: BoxDecoration(
              color: AppTheme.getInstance().backgroundBTSColor(),
              borderRadius: BorderRadius.circular(20),
            ),
            resultTS: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
            ),
            placeholder: 'Select country',
            resultIcon: const SizedBox.shrink(),
            selectedItemTS: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
            ),
            unselectedItemTS: textNormal(
              AppTheme.getInstance().whiteColor(),
              16,
            ),
            placeholderTS: textNormal(
              Colors.white.withOpacity(0.5),
              16,
            ),
            isTriangle: false,
            selectedItemBD: BoxDecoration(
              color: AppTheme.getInstance().whiteColor().withOpacity(0.1),
            ),
          ),
          Positioned(
            right: 19.w,
            child: SizedBox(
              height: 64.h,
              child: sizedSvgImage(
                w: 13,
                h: 13,
                image: ImageAssets.ic_expand_white_svg,
              ),
            ),
          )
        ],
      );
    } else if (typeDrop == TYPE_FORM_DROPDOWN.PRICE) {
      return SizedBox(
        width: 90.w,
        child: Center(
          child: Stack(
            children: [
              Positioned(
                child: CoolDropdown(
                  dropdownItemGap: 8.h,
                  dropdownItemMainAxis: MainAxisAlignment.start,
                  resultMainAxis: MainAxisAlignment.start,
                  isTriangle: false,
                  dropdownList: tokensMap,
                  dropdownWidth: 113.w,
                  dropdownHeight: 228.h,
                  dropdownPadding: EdgeInsets.only(right: 11.w),
                  dropdownItemHeight: 54.h,
                  defaultValue: tokensMap[0],
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
                    print(value['label']);
                  },
                ),
              ),
              Positioned(
                right: 6.w,
                child: SizedBox(
                  height: 60.h,
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
    } else if (typeDrop == TYPE_FORM_DROPDOWN.PHONE) {
      return Container(
        decoration: BoxDecoration(
          color: AppTheme.getInstance().backgroundBTSColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            bottomLeft: Radius.circular(20.r),
          ),
        ),
        width: 93.w,
        height: 64.h,
        child: Center(
          child: Stack(
            children: [
              CoolDropdown(
                dropdownItemGap: 8.h,
                dropdownItemMainAxis: MainAxisAlignment.start,
                resultMainAxis: MainAxisAlignment.spaceAround,
                dropdownHeight: 324.h,
                dropdownWidth: 109.w,
                isTriangle: false,
                dropdownPadding: EdgeInsets.only(right: 11.w),
                dropdownList: phones,
                defaultValue: phones[0],
                resultIcon: const SizedBox.shrink(),
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
                  print(value['label']);
                },
              ),
              Positioned(
                top: 0.h,
                left: 60.w,
                child: SizedBox(
                  height: 60.h,
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
    } else {
      return Container();
    }
  }
}
