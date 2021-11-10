import 'package:Dfy/presentation/change_password/ui/change_password.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/button_form.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/header_setting.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:Dfy/generated/l10n.dart';

class SettingWallet extends StatelessWidget {
  const SettingWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 764.h,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(62, 61, 92, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          headerSetting(
            leftFunction: () {},
            rightFunction: () {},
          ),
          const Divider(
            thickness: 1,
            color: Color.fromRGBO(255, 255, 255, 0.1),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 24.h,
                  ),
                  buttonForm(
                    hintText: 'Dapp',
                    prefixIcon: ImageAssets.global,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  buttonForm(
                    hintText: S.current.select_acc,
                    prefixIcon: ImageAssets.slc_acc,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  buttonForm(
                    hintText: S.current.create_new_acc,
                    prefixIcon: ImageAssets.plus,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  buttonForm(
                    hintText: S.current.import_acc,
                    prefixIcon: ImageAssets.import,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  buttonForm(
                    hintText: S.current.show_key_seed,
                    prefixIcon: ImageAssets.key,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    child: buttonForm(
                      hintText: S.current.change_password,
                      prefixIcon: ImageAssets.security,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => ChangePassword(

                        ),
                        context: context,
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  switchForm(
                    prefixImg: ImageAssets.key,
                    isCheck: true,
                    callBack: () {},
                    hintText: S.current.face_touch_id,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  switchForm(
                    prefixImg: ImageAssets.lock,
                    isCheck: false,
                    callBack: () {},
                    hintText: S.current.app_wallet_lock,
                  ),SizedBox(
                    height: 51.h,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
