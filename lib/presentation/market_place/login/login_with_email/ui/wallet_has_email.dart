import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletHasEmail extends StatelessWidget {
  final String token;
  final String email;

  const WalletHasEmail({Key? key, required this.token, required this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ButtonLuxuryBigSize(
        title: S.current.login,
        isEnable: true,
        onTap: () {
          //TODO: CALL API LOGIN EMAIL
          Navigator.pop(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BaseDesignScreen(
        title: S.current.connect_wallet,
        child: Column(
          children: [
            SizedBox(
              height: 110.h,
            ),
            Image.asset(
              ImageAssets.img_login,
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12,
                right: 15,
                bottom: 14,
                left: 16,
              ),
              child: RichText(
                text: TextSpan(
                  text: token,
                  style: textNormal(
                    AppTheme.getInstance().textThemeColor(),
                    16,
                  ).copyWith(fontWeight: FontWeight.bold),
                  children: <TextSpan>[
                    TextSpan(
                      text: S.current.already_associated,
                      style: textNormal(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                      ),
                    ),
                    TextSpan(
                      text: email,
                      style: textNormal(
                        AppTheme.getInstance().textThemeColor(),
                        16,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 15,
                bottom: 14,
                left: 16,
              ),
              child: Text(
                S.current.login_with_this_email,
                style: textNormal(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
