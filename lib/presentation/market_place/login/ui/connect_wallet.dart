import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/market_place/login/ui/token_has_email.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
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
        onTap: () => showDialog(
          context: context,
          builder: (context) => const ConnectWalletDialog(),
        ),
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
                16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
