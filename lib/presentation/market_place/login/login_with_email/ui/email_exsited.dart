import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/login/ui/login_screen.dart';
import 'package:Dfy/presentation/market_place/login/connect_wallet_dialog/ui/connect_wallet_dialog.dart';
import 'package:Dfy/presentation/market_place/ui/market_place_screen.dart';
import 'package:Dfy/presentation/wallet/bloc/wallet_cubit.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_design_screen.dart';
import 'package:flutter/material.dart';

class EmailExisted extends StatefulWidget {
  final String email;

  const EmailExisted({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailExisted> createState() => _EmailExistedState();
}

class _EmailExistedState extends State<EmailExisted> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: ButtonLuxuryBigSize(
        title: S.current.confirm_account,
        isEnable: true,
        onTap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: BaseDesignScreen(
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
                S.current.detected_email +
                    widget.email +
                    S.current.detected_email2,
                style: textNormal(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
