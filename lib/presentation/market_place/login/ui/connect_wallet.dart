import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/domain/model/market_place/user_profile_model.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/email_exsited.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/enter_email_screen.dart';
import 'package:Dfy/presentation/market_place/login/ui/wallet_has_email.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectWallet extends StatelessWidget {
  const ConnectWallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ButtonLuxuryBigSize(
        title: S.current.connect_wallet,
        isEnable: true,
        onTap: () {
          final profileJson = PrefsService.getUserProfile();
          final walletAddress = PrefsService.getCurrentBEWallet().handleString();
          final UserProfileModel profile = userProfileFromJson(
            profileJson,
          );
          final String email = profile.email ?? '';
          if (email.isEmpty) {
            //tài khoản chưa liên kết email => Chuyển màn nhập email
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const EnterEmail(),
              ),
            ).then((value) => {
              if(value){
                Navigator.pop(context,true)
              }
            });
          } else {
            //ví đã liên kết email:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WalletHasEmail(
                  token: walletAddress,
                  email: email,
                ),
              ),
            );
          }

        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BaseBottomSheet(
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
            Text(
              S.current.connect_to_continue,
              style: textNormal(
                AppTheme.getInstance().textThemeColor(),
                16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
