import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/change_password/ui/change_password.dart';
import 'package:Dfy/presentation/setting_wallet/bloc/setting_wallet_cubit.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/button_form.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/header_setting.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/ui/confirm_pw_prvkey_seedpharse.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum typeSwitchForm { FINGER_FT_FACEID, APPLOCK }

class SettingWallet extends StatelessWidget {
  SettingWallet({required this.cubit, Key? key}) : super(key: key);
  SettingWalletCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 764.h,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          headerSetting(
            leftFunction: () {
              Navigator.pop(context);
            },
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
                    prefixIcon: ImageAssets.ic_global,
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
                    prefixIcon: ImageAssets.ic_add,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  buttonForm(
                    hintText: S.current.import_acc,
                    prefixIcon: ImageAssets.ic_import,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => ConfirmPWShowPRVSeedPhr(
                          cubit: ConfirmPwPrvKeySeedpharseCubit(),
                        ),
                        context: context,
                      );
                    },
                    child: buttonForm(
                      hintText: S.current.show_key_seed,
                      prefixIcon: ImageAssets.ic_key24,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    child: buttonForm(
                      hintText: S.current.change_password,
                      prefixIcon: ImageAssets.ic_security,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => const ChangePassword(),
                        context: context,
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  StreamBuilder<bool>(
                    stream: cubit.isSwitchFingerFtFaceIdOnStream,
                    builder: (context, snapshot) {
                      return switchForm(
                        prefixImg: ImageAssets.ic_key24,
                        isCheck: snapshot.data ?? false,
                        hintText: S.current.face_touch_id,
                        cubit: cubit,
                        type: typeSwitchForm.FINGER_FT_FACEID,
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  StreamBuilder<bool>(
                      stream: cubit.isSwitchAppLockOnStream,
                      builder: (context, snapshot) {
                        return switchForm(
                          prefixImg: ImageAssets.ic_lock,
                          isCheck: snapshot.data ?? false,
                          hintText: S.current.app_wallet_lock,
                          type: typeSwitchForm.APPLOCK,
                          cubit: cubit,
                        );
                      }),
                  SizedBox(
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
