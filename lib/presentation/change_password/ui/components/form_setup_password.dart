import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/presentation/change_password/bloc/change_password_cubit.dart';
import 'package:Dfy/presentation/change_password/ui/change_password.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Container formSetupPassWord({
  required TextEditingController controller,
  required String hintText,
  String? oldPassWordFetch,
  required ChangePasswordCubit cubit,
  required typeForm type,
}) {
  if (type == typeForm.OLD) {
    int index = 0;
    return Container(
      height: 64.h,
      width: 343.w,
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: StreamBuilder<bool>(
        stream: cubit.showOldStream,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: (value) {
              cubit.checkHaveValueOldPW(value);
            },
            obscureText: snapshot.data ?? true,
            style: textNormal(
              Colors.white,
              16,
            ),
            cursorColor: Colors.white,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textNormal(
                Colors.grey,
                14,
              ),
              suffixIcon: InkWell(
                onTap: () {
                  if (index == 0) {
                    index = 1;
                    cubit.showOldPW(0);
                  } else {
                    index = 0;
                    cubit.showOldPW(1);
                  }
                },
                child: snapshot.data ?? false
                    ? const ImageIcon(
                        AssetImage(ImageAssets.ic_show),
                        color: Colors.grey,
                      )
                    : const ImageIcon(
                        AssetImage(ImageAssets.ic_hide),
                        color: Colors.grey,
                      ),
              ),
              prefixIcon: const ImageIcon(
                AssetImage(ImageAssets.ic_lock),
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          );
        },
      ),
    );
  } else if (type == typeForm.NEW) {
    int index = 0;
    return Container(
      height: 64.h,
      width: 343.w,
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: StreamBuilder<bool>(
        stream: cubit.showNewPWStream,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: (value) {
              cubit.checkHaveValueNewPW(value);
            },
            obscureText: snapshot.data ?? true,
            style: textNormal(
              Colors.white,
              16,
            ),
            cursorColor: Colors.white,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textNormal(
                Colors.grey,
                14,
              ),
              suffixIcon: InkWell(
                  onTap: () {
                    if (index == 0) {
                      index = 1;
                      cubit.showNewPW(0);
                    } else {
                      index = 0;
                      cubit.showNewPW(1);
                    }
                  },
                  child: snapshot.data ?? false
                      ? const ImageIcon(
                          AssetImage(ImageAssets.ic_show),
                          color: Colors.grey,
                        )
                      : const ImageIcon(
                          AssetImage(ImageAssets.ic_hide),
                          color: Colors.grey,
                        )),
              prefixIcon: const ImageIcon(
                AssetImage(ImageAssets.ic_lock),
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          );
        },
      ),
    );
  } else {
    int index = 0;
    return Container(
      height: 64.h,
      width: 343.w,
      padding: EdgeInsets.only(
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Color(0xff32324c),
      ),
      child: StreamBuilder<bool>(
        stream: cubit.showCfPWStream,
        builder: (context, snapshot) {
          return TextFormField(
            onChanged: (value) {
              cubit.checkHaveValueConfirmPW(value);
            },
            obscureText: snapshot.data ?? true,
            style: textNormal(
              Colors.white,
              16,
            ),
            cursorColor: Colors.white,
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: textNormal(
                Colors.grey,
                14,
              ),
              suffixIcon: InkWell(
                  onTap: () {
                    if (index == 0) {
                      index = 1;
                      cubit.showConfirmPW(0);
                    } else {
                      index = 0;
                      cubit.showConfirmPW(1);
                    }
                  },
                  child: snapshot.data ?? false
                      ? const ImageIcon(
                          AssetImage(ImageAssets.ic_show),
                          color: Colors.grey,
                        )
                      : const ImageIcon(
                          AssetImage(ImageAssets.ic_hide),
                          color: Colors.grey,
                        )),
              prefixIcon: const ImageIcon(
                AssetImage(ImageAssets.ic_lock),
                color: Colors.white,
              ),
              border: InputBorder.none,
            ),
          );
        },
      ),
    );
  }
}
