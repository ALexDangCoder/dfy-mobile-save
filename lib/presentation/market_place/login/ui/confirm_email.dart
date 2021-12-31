import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/ui/email_exsited.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmEmail extends StatelessWidget {
  const ConfirmEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: ButtonLuxuryBigSize(
        title: S.current.confirm_account,
        isEnable: true,
        onTap: () {
          //todo:
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const EmailExisted(email: 'vund.0709@gmail.com'),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BaseBottomSheet(
        title: S.current.enter_email,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: Text(
                S.current.verify_account,
                style: textNormal(
                  AppTheme.getInstance().textThemeColor(),
                  16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
