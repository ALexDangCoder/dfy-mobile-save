import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/change_password/ui/change_password.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrase1.dart';
import 'package:Dfy/presentation/restore_bts/ui/restore_bts.dart';
import 'package:Dfy/presentation/select_acc/ui/select_acc.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/button_form.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/header_setting.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/ui/confirm_pw_prvkey_seedpharse.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingWallet extends StatelessWidget {
  const SettingWallet({Key? key, required this.cubit}) : super(key: key);
  final WalletCubit cubit;

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
            context: context,
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
                  GestureDetector(
                    onTap: () {
                      showSelectAcc(
                        context,
                        cubit,
                        TypeScreen2.setting,
                      );
                    },
                    child: buttonForm(
                      hintText: S.current.select_acc,
                      prefixIcon: ImageAssets.slc_acc,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showCreateSeedPhrase1(
                        context,
                        true,
                        BLocCreateSeedPhrase(''),
                        TypeScreen.one,
                      );
                    },
                    child: buttonForm(
                      hintText: S.current.create_new_acc,
                      prefixIcon: ImageAssets.plus,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => const RestoreBTS(),
                        context: context,
                      );
                    },
                    child: buttonForm(
                      hintText: S.current.import_acc,
                      prefixIcon: ImageAssets.import,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        builder: (context) => const ConfirmPWShowPRVSeedPhr(),
                        context: context,
                      );
                    },
                    child: buttonForm(
                      hintText: S.current.show_key_seed,
                      prefixIcon: ImageAssets.key,
                    ),
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
                        builder: (context) => const ChangePassword(),
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
                  ),
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
