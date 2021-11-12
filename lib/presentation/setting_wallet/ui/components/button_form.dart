import 'package:Dfy/config/themes/app_theme.dart';
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
    margin: EdgeInsets.only(
      left: 16.w,
      right: 16.w,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
      color: const Color(0xff32324c),
    ),
    child: Row(
      children: [
        IconButton(onPressed: () {}, icon: Image.asset(prefixIcon)),
        Text(
          hintText,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: Colors.white,
          ),
        )
      ],
    ),
  );
}

Container switchForm({
  required String prefixImg,
  required bool isCheck,
  required Function()? callBack,
  required String hintText,
}) {
  return Container(
    width: 343.w,
    height: 64.h,
    margin: EdgeInsets.only(
      left: 16.w,
      right: 16.w,
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20.r)),
      color: const Color(0xff32324c),
    ),
    child: ListTileSwitch(
      value: isCheck,
      onChanged: (bool value) => callBack,
      //todo
      leading: Image.asset(prefixImg),
      switchActiveColor: AppTheme.getInstance().fillColor(),
      switchType: SwitchType.cupertino,
      title: Text(
        hintText,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    ),
  );
}
