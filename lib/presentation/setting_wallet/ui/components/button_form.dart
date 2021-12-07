import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/presentation/setting_wallet/bloc/setting_wallet_cubit.dart';
import 'package:Dfy/presentation/setting_wallet/ui/setting_wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:list_tile_switch/list_tile_switch.dart';

Container buttonForm({
  required String hintText,
  required String prefixIcon,
}) {
  return Container(
    width: 343.w,
    height: 64.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
      color: AppTheme.getInstance().itemBtsColors(),
    ),
    child: Row(
      children: [
        IconButton(onPressed: () {}, icon: Image.asset(prefixIcon)),
        Text(
          hintText,
          style: textNormalCustom(Colors.white, 16, FontWeight.w400),
        )
      ],
    ),
  );
}

Container switchForm({
  required String prefixImg,
  required bool isCheck,
  required String hintText,
  required SettingWalletCubit cubit,
  required typeSwitchForm type,
}) {
  if (type == typeSwitchForm.FINGER_FT_FACEID) {
    return Container(
      width: 343.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: ListTileSwitch(
          enabled: false,
          switchScale: 1,
          value: isCheck,
          onChanged: (bool value) =>
              cubit.changeValueFingerFtFaceID(value: value),
          //todo
          leading: SizedBox(
            // height: 20,
            width: 200,
            child: Center(
              child: Row(
                children: [
                  Image.asset(prefixImg),
                  spaceW10,
                  Text(
                    hintText,
                    style: textNormalCustom(Colors.white, 16, FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          switchActiveColor: AppTheme.getInstance().fillColor(),
          switchType: SwitchType.cupertino,
        ),
      ),
    );
  } else {
    return Container(
      width: 343.w,
      height: 64.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: AppTheme.getInstance().itemBtsColors(),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: ListTileSwitch(
          enabled: false,
          switchScale: 1,
          value: isCheck,
          onChanged: (value) {
            cubit.changeValueAppLock(value: value);
            cubit.setIsAppLock(value: value);
          },
          //todo
          leading: SizedBox(
            // height: 20,
            width: 200,
            child: Center(
              child: Row(
                children: [
                  Image.asset(prefixImg),
                  spaceW12,
                  Text(
                    hintText,
                    style: textNormalCustom(Colors.white, 16, FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          switchActiveColor: AppTheme.getInstance().fillColor(),
          switchType: SwitchType.cupertino,
          // leading: Image.asset(prefixImg),
          // switchActiveColor: AppTheme.getInstance().fillColor(),
          // switchType: SwitchType.cupertino,
        ),
      ),
    );
  }
}
