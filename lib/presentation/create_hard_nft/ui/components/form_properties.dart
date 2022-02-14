import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/create_hard_nft/bloc/provide_hard_nft_info/provide_hard_nft_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum IS_HAVE_DATA { YES, NO }

class FormProperties extends StatelessWidget {
  const FormProperties({
    Key? key,
    required this.data,
    required this.cubit,
  }) : super(key: key);

  final PropertyModel data;
  final ProvideHardNftCubit cubit;

  @override
  Widget build(BuildContext context) {
    String propertyForm = data.property;
    String valueForm = data.value;
    return Container(
      width: 272.w,
      // height: 116.h,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      margin: EdgeInsets.only(bottom: 18.h, left: 20.w, right: 20.w),
      padding: EdgeInsets.only(
        top: 6.h,
        bottom: 6.h,
        left: 13.w,
      ),
      child: Column(
        children: [
          TextFormField(
            initialValue: propertyForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.length > 30) {
                data.property = '';
                cubit.checkPropertiesWhenSave();
                return S.current.maximum_30;
              }
              return null;
            },
            onChanged: (value) {
              propertyForm = value;
              data.property = propertyForm;
            },
            cursorColor: AppTheme.getInstance().textThemeColor(),
            style: textNormal(
              AppTheme.getInstance().textThemeColor(),
              16.sp,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: S.current.properties,
              hintStyle: textNormalCustom(
                AppTheme.getInstance().whiteOpacityDot5(),
                16,
                FontWeight.w400,
              ),
              contentPadding: EdgeInsets.only(
                top: 10.h,
                bottom: 10.h,
              ),
              filled: true,
            ),
          ),
          Container(
            width: 248.w,
            height: 1,
            color: AppTheme.getInstance().divideColor(),
          ),
          TextFormField(
            initialValue: valueForm,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value!.length > 30) {
                data.value = '';
                cubit.checkPropertiesWhenSave();
                return S.current.maximum_30;
              }
              return null;
            },
            onChanged: (value) {
              valueForm = value;
              data.value = valueForm;
            },
            cursorColor: AppTheme.getInstance().textThemeColor(),
            style: textNormal(
              AppTheme.getInstance().textThemeColor(),
              16.sp,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: S.current.value,
              hintStyle: textNormalCustom(
                AppTheme.getInstance().whiteOpacityDot5(),
                16,
                FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
