import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/change_password/ui/change_password.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/show_create_seedphrase1.dart';
import 'package:Dfy/presentation/import_account_login_bts/ui/import_account_login.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/select_acc/ui/select_acc.dart';
import 'package:Dfy/presentation/send_token_nft/ui/send_token/send_token.dart';
import 'package:Dfy/presentation/setting_wallet/bloc/setting_wallet_cubit.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/button_form.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/ui/confirm_pw_prvkey_seedpharse.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum typeSwitchForm { FINGER_FT_FACEID, APPLOCK }

class SettingWallet extends StatelessWidget {
  const SettingWallet({
    required this.cubit,
    Key? key,
    required this.cubitSetting,
  }) : super(key: key);
  final SettingWalletCubit cubitSetting;
  final WalletCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      title: S.current.setting,
      text: S.current.lock,
      isImage: false,
      callback: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const MainScreen(
              index: 2,
            ),
          ),
          (route) => route.isFirst,
        );
      },
      child: Column(
        children: [
          spaceH24,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // showModalBottomSheet(
                      //   isScrollControlled: true,
                      //   backgroundColor: Colors.transparent,
                      //   context: context,
                      //   builder: (_) {
                      //     return const SendToken();
                      //   },
                      // );
                    },
                    child: buttonForm(
                      hintText: 'Dapp',
                      prefixIcon: ImageAssets.ic_global,
                    ),
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
                      prefixIcon: ImageAssets.ic_wallet,
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
                      prefixIcon: ImageAssets.ic_add,
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
                        builder: (context) => const ImportBTS(),
                        context: context,
                      );
                    },
                    child: buttonForm(
                      hintText: S.current.import_acc,
                      prefixIcon: ImageAssets.ic_import,
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
                    stream: cubitSetting.isSwitchFingerFtFaceIdOnStream,
                    builder: (context, snapshot) {
                      return switchForm(
                        prefixImg: ImageAssets.ic_face_id,
                        isCheck: snapshot.data ?? false,
                        hintText: S.current.face_touch_id,
                        cubit: cubitSetting,
                        type: typeSwitchForm.FINGER_FT_FACEID,
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  StreamBuilder<bool>(
                    stream: cubitSetting.isSwitchAppLockOnStream,
                    builder: (context, snapshot) {
                      return switchForm(
                        prefixImg: ImageAssets.ic_lock,
                        isCheck: snapshot.data ?? true,
                        hintText: S.current.app_wallet_lock,
                        type: typeSwitchForm.APPLOCK,
                        cubit: cubitSetting,
                      );
                    },
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
