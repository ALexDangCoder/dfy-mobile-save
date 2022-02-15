import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/utils/app_utils.dart';
import 'package:Dfy/widgets/button/button_luxury_big_size.dart';
import 'package:Dfy/widgets/common_bts/base_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ConfirmEmail extends StatefulWidget {
  const ConfirmEmail({
    Key? key,
    required this.transactionId,
    required this.email,
  }) : super(key: key);
  final String transactionId;
  final String email;

  @override
  State<ConfirmEmail> createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> {
  TextEditingController otpController = TextEditingController();
  LoginWithEmailCubit cubit = LoginWithEmailCubit();

  @override
  void initState() {
    super.initState();
    cubit.startTimer();
  }
  @override
  void dispose() {
    super.dispose();
    cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: ButtonLuxuryBigSize(
          title: S.current.confirm_account,
          isEnable: true,
          onTap: () async {
            if (otpController.value.text.length != 6) {
              showErrDialog(
                context: context,
                title: S.current.warning,
                content: S.current.otp_invalid,
              );
            } else {
              showLoading(context);
              final bool isSuccess = await cubit.verifyOTP(
                otp: otpController.value.text,
                transactionID: widget.transactionId,
              );
              hideLoading(context);
              if (isSuccess) {
                Navigator.pop(context, true);
              } else {
                showErrDialog(context: context, title: S.current.warning, content: S.current.expired_code,);
              }
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BaseDesignScreen(
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
                    borderWidth: 1,
                    fieldWidth: 50,
                    //backgound khi đã truyền param
                    activeFillColor: AppTheme.getInstance().yellowOpacity10(),
                    //border khi đã truyền param
                    activeColor: AppTheme.getInstance().fillColor(),
                    //màu border khi click vào
                    selectedColor: AppTheme.getInstance().colorTextReset(),
                    //bg color của input đang focus
                    selectedFillColor: AppTheme.getInstance().darkBgColor(),
                    //bg color của input chưa có giá trị
                    inactiveFillColor: AppTheme.getInstance().darkBgColor(),
                    //border  color của input chưa có giá trị
                    inactiveColor: AppTheme.getInstance().bgTranSubmit(),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (_) {},
                  onChanged: (_) {},
                  controller: otpController,
                  beforeTextPaste: (text) {
                    return false;
                  },
                  appContext: context,
                  length: 6,
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              StreamBuilder<int>(
                stream: cubit.timeCountDownStream,
                builder: (context, snapshot) {
                  return Center(
                    child: Text(
                      '(${snapshot.data})',
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        24,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 8.h,
              ),
              StreamBuilder<bool>(
                  stream: cubit.isEnableResendSubject,
                  builder: (context, snapshot) {
                    return GestureDetector(
                      onTap: () {
                        if (snapshot.data ?? false) {
                          cubit.sendOTP(
                            email: widget.email,
                            type: 1,
                          );
                          cubit.startTimer();
                        }
                      },
                      child: Center(
                        child: Text(
                          S.current.resend_code,
                          style: textNormal(
                            snapshot.data ?? false
                                ? const Color(0xFFE4AC1A)
                                : const Color(0xFF828282),
                            16,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
