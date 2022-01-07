import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/widget/enter_otp.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/email_exsited.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmEmail extends StatefulWidget {
  const ConfirmEmail({Key? key}) : super(key: key);

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  TextEditingController otpController = TextEditingController();
  LoginWithEmailCubit cubit = LoginWithEmailCubit();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: ButtonLuxuryBigSize(
          title: S.current.confirm_account,
          isEnable: true,
          onTap: () {
            //todo:
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EmailExisted(
                  email: 'vund.0709@gmail.com',
                  cubit: cubit,
                ),
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BaseBottomSheet(
          title: S.current.enter_email,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
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
                OtpTextField(
                  controller: otpController,
                  countDown: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
