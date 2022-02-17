import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/main.dart';
import 'package:Dfy/presentation/change_password/ui/change_password.dart';
import 'package:Dfy/presentation/create_hard_nft/ui/provide_hard_nft_info.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/ui/create_seedphrase.dart';
import 'package:Dfy/presentation/import_account/ui/import_account_login.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/presentation/on_boarding/ui/on_boarding.dart';
import 'package:Dfy/presentation/select_acc/ui/select_acc.dart';
import 'package:Dfy/presentation/setting_wallet/bloc/setting_wallet_cubit.dart';
import 'package:Dfy/presentation/setting_wallet/ui/components/button_form.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/bloc/confirm_pw_prvkey_seedpharse_cubit.dart';
import 'package:Dfy/presentation/show_pw_prvkey_seedpharse/ui/confirm_pw_prvkey_seedpharse.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:Dfy/widgets/views/coming_soon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum typeSwitchForm { FINGER_FT_FACEID, APPLOCK }

class SettingWallet extends StatefulWidget {
  const SettingWallet({
    required this.cubit,
    Key? key,
    required this.cubitSetting,
  }) : super(key: key);
  final SettingWalletCubit cubitSetting;
  final WalletCubit cubit;

  @override
  State<SettingWallet> createState() => _SettingWalletState();
}

class _SettingWalletState extends State<SettingWallet> {
  final ConfirmPwPrvKeySeedpharseCubit cubit = ConfirmPwPrvKeySeedpharseCubit();

  @override
  void initState() {
    trustWalletChannel.setMethodCallHandler(
        widget.cubitSetting.nativeMethodCallBackTrustWallet);
    widget.cubitSetting.getConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: S.current.setting,
      isLockTextInSetting: true,
      widget: buildTextHideFtShow(),
      isImage: false,
      child: Column(
        children: [
          spaceH24,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ComingSoon();
                          },
                        ),
                      );
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SelectAcc(
                              bloc: widget.cubit,
                              typeScreen2: TypeScreen2.setting,
                            );
                          },
                        ),
                      ).whenComplete(
                        () => {
                          widget.cubit.listWallet.clear(),
                          widget.cubit.getListWallets(),
                          widget.cubit.getListAcc(),
                        },
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CreateSeedPhrase(
                              bloc: BLocCreateSeedPhrase(''),
                              type: TypeScreen.one,
                            );
                          },
                        ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ImportAccount(),
                        ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return ConfirmPWShowPRVSeedPhr(
                              cubit: cubit,
                            );
                          },
                        ),
                      ).whenComplete(
                        () => {
                          cubit.listWalletCore.clear(),
                        },
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) {
                            return const ChangePassword();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  StreamBuilder<bool>(
                    stream: widget.cubitSetting.isSwitchFingerFtFaceIdOnStream,
                    builder: (context, snapshot) {
                      return switchForm(
                        prefixImg: ImageAssets.ic_face_id,
                        isCheck: snapshot.data ?? false,
                        hintText: S.current.face_touch_id,
                        cubit: widget.cubitSetting,
                        type: typeSwitchForm.FINGER_FT_FACEID,
                      );
                    },
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  StreamBuilder<bool>(
                    stream: widget.cubitSetting.isSwitchAppLockOnStream,
                    builder: (context, snapshot) {
                      return switchForm(
                        prefixImg: ImageAssets.ic_lock,
                        isCheck: snapshot.data ?? true,
                        hintText: S.current.app_wallet_lock,
                        type: typeSwitchForm.APPLOCK,
                        cubit: widget.cubitSetting,
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

  StreamBuilder<String> buildTextHideFtShow() {
    return StreamBuilder<String>(
      stream: widget.cubitSetting.textLockSetting,
      builder: (context, snapshot) {
        if (snapshot.data == '') {
          return Flexible(
            child: Text(
              S.current.lock,
              style: textNormalCustom(
                AppTheme.getInstance().bgBtsColor(),
                16,
                FontWeight.w700,
              ),
            ),
          );
        } else {
          return Flexible(
            child: InkWell(
              onTap: () {
                PrefsService.clearWalletLogin();
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(
                      index: loginIndex,
                    ),
                  ),
                  (route) => route.isFirst,
                );
              },
              child: Text(
                S.current.lock,
                style: textNormalCustom(
                  AppTheme.getInstance().fillColor(),
                  16,
                  FontWeight.w700,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
