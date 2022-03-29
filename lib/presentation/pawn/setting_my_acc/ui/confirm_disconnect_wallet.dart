import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/setting_my_acc/cubit/setting_my_acc_cubit.dart';
import 'package:Dfy/utils/pop_up_notification.dart';
import 'package:Dfy/widgets/button/button_gradient.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDisconnectWallet extends StatelessWidget {
  const ConfirmDisconnectWallet(
      {Key? key, required this.wallet, required this.cubit})
      : super(key: key);

  final String wallet;
  final SettingMyAccCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BaseDesignScreen(
      title: 'Confirmation',
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: 24.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disassociate this wallet and you will not receive any email notification related to this wallet, including important emails about loan contracts.',
              style: textNormalCustom(
                Colors.white,
                16,
                FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 489.h,
            ),
            Text(
              'You can link wallet new account to receive email notification again.',
              style: textNormalCustom(
                Colors.white.withOpacity(0.7),
                16,
                FontWeight.w400,
              ),
            ),
            spaceH24,
            ButtonGradient(
              onPressed: () {
                cubit.removeWallet(wallet);
                showLoadSuccess(context).then(
                  (value) => Navigator.of(context).pop(),
                );
              },
              gradient: RadialGradient(
                center: const Alignment(0.5, -0.5),
                radius: 4,
                colors: AppTheme.getInstance().gradientButtonColor(),
              ),
              child: Text(
                S.current.submit,
                style: textNormalCustom(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                  FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
