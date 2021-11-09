import 'dart:ui';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/image_asset.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/routes/router.dart';
import 'package:Dfy/presentation/create_wallet_first_time/create_seedphrare/bloc/bloc_creare_seedphrase.dart';
import 'package:Dfy/presentation/login/ui/login_screen.dart';
import 'package:Dfy/presentation/main_screen/ui/main_screen.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/form/form_switch.dart';
import 'package:Dfy/widgets/form/form_switch1.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCreateSuccessfully(
    BuildContext context, BLocCreateSeedPhrase bLocCreateSeedPhrase) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: 764.h,
        width: 375.w,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          color: AppTheme.getInstance().bgBtsColor(),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 18.h,
            ),
            Center(
              child: Text(
                S.current.success,
                style: textNormal(
                  AppTheme.getInstance().whiteWithOpacity(),
                  20.sp,
                ).copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            spaceH20,
            line,
            spaceH24,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(ImageAssets.icFrame),
                    SizedBox(
                      height: 22.h,
                    ),
                    Text(
                      S.current.congratulation,
                      style: textNormal(
                        AppTheme.getInstance().whiteWithOpacity(),
                        32.sp,
                      ).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 111.h,
                    ),
                    StreamBuilder(
                      stream: bLocCreateSeedPhrase.isCheckAppLock,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return FromSwitch1(
                          bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                          title:  S.current.use_face,
                          isCheck: snapshot.data ?? false,
                          urlPrefixIcon: ImageAssets.icFace,
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    StreamBuilder(
                      stream: bLocCreateSeedPhrase.isCheckTouchID,
                      builder: (context, AsyncSnapshot<bool> snapshot) {
                        return FromSwitch(
                          bLocCreateSeedPhrase: bLocCreateSeedPhrase,
                          title:  S.current.wallet_app_lock,
                          isCheck: snapshot.data ?? false,
                          urlPrefixIcon: ImageAssets.icPassword,
                        );
                      },
                    ),
                    SizedBox(
                      height: 56.h,
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  //Navigator.popAndPushNamed(context,AppRouter.login);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRouter.main,
                    (route) => route.isFirst,
                  );
                },
                child: const ButtonGold(
                  S.current.wallet_app_lock,
                  isEnable: true,
                ),
              ),
            ),
            SizedBox(
              height: 38.h,
            ),
          ],
        ),
      );
    },
  );
}
