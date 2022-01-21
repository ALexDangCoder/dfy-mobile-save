import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/email_exsited.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Enter Code',
                style: textNormal(
                  AppTheme.getInstance().textThemeColor(),
                  16,
                ).copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: PinCodeTextField(
                obscureText: false,
                animationType: AnimationType.fade,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(12),
                  fieldHeight: 60,
                  fieldWidth: 50,
                  activeFillColor: const Color(0x1AE4AC1A),
                  activeColor: const Color(0XFFE4AC1A),
                  selectedColor: const Color(0x1AE4AC1A),
                  selectedFillColor: const Color(0x1AE4AC1A),
                  errorBorderColor: const Color(0xFF585782),
                  disabledColor: const Color(0XFF33324C),
                ),
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                },
                appContext: context,
                length: 6,
              ),
            )
          ],
        ),
      ),
    );
  }
}
