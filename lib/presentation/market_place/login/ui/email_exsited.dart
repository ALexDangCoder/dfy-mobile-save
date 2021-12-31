import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/bloc/connect_wallet_cubit.dart';
import 'package:Dfy/presentation/market_place/login/bloc/login_cubit.dart';
import 'package:Dfy/presentation/market_place/login/ui/dialog/confirm_dialog.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../main.dart';

class EmailExisted extends StatefulWidget {
  final String email;
  const EmailExisted({Key? key, required this.email}) : super(key: key);

  @override
  State<EmailExisted> createState() => _EmailExistedState();
}

class _EmailExistedState extends State<EmailExisted> {
  late ConnectWalletCubit connectWalletCubit;

  @override
  void initState() {
    super.initState();
    connectWalletCubit = ConnectWalletCubit();
    trustWalletChannel.setMethodCallHandler(connectWalletCubit.nativeMethodCallBackTrustWallet);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: ButtonLuxuryBigSize(
        title: S.current.confirm_account,
        isEnable: true,
        onTap: (){
          connectWalletCubit.getListWallet();

          // showDialog(
          //   context: context,
          //   builder: (context) => ConfirmDialog(
          //     onRightBtnClick: () {},
          //     content: '',
          //     contentRightButton: '',
          //     contentLeftButton: '',
          //   ),
          // );
        }
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
                S.current.detected_email + widget.email + S.current.detected_email2,
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
