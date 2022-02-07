import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/my_account/create_nft/bloc/create_nft_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget propertyRow({
  required CreateNftCubit cubit,
  required int index,
  required Map<String, String> property,
  required Function onTap,
}) {
  return Container(
    key: UniqueKey(),
    height: 116.h,
    margin: EdgeInsets.only(bottom: 16.h),
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    decoration: BoxDecoration(
      color: AppTheme.getInstance().backgroundBTSColor(),
      borderRadius: BorderRadius.all(
        Radius.circular(20.r),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    // controller: textController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(256),
                    ],
                    cursorColor: AppTheme.getInstance().whiteColor(),
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
                    onChanged: (value) {
                      // onChange(value);
                    },
                    decoration: InputDecoration(
                      hintText: S.current.properties,
                      hintStyle: textNormal(
                        Colors.white.withOpacity(0.5),
                        16,
                      ),
                      suffixStyle: textCustom(),
                      border: InputBorder.none,
                    ),
                    initialValue: property['key'],
                    // onFieldSubmitted: ,
                  ),
                ),
              ),
              line,
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TextFormField(
                    // controller: textController,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(256),
                    ],
                    cursorColor: AppTheme.getInstance().whiteColor(),
                    style: textNormal(
                      AppTheme.getInstance().whiteColor(),
                      16,
                    ),
                    onChanged: (value) {
                      // onChange(value);
                    },
                    decoration: InputDecoration(
                      hintText: S.current.value,
                      hintStyle: textNormal(
                        Colors.white.withOpacity(0.5),
                        16,
                      ),
                      suffixStyle: textCustom(),
                      border: InputBorder.none,
                    ),
                    initialValue: property['value'],
                    // onFieldSubmitted: ,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 16.w),
          child: GestureDetector(
            onTap: () {
              onTap();
            },
            child: sizedSvgImage(w: 20, h: 20, image: ImageAssets.delete_svg),
          ),
        ),
      ],
    ),
  );
}
