import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpTextField extends StatefulWidget {
  OtpTextField({
    Key? key,
    required this.controller,
    required this.countDown,
  }) : super(key: key);
  final TextEditingController controller;
  int countDown;

  @override
  _OtpTextFieldState createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<OtpTextField> {
  LoginWithEmailCubit cubit = LoginWithEmailCubit();

  @override
  void initState() {
    cubit.startTimer(timeStart: widget.countDown);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isEnableResend = false;
    final int startTime = widget.countDown;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Code',
          style: textNormal(
            AppTheme.getInstance().textThemeColor(),
            16,
          ).copyWith(fontWeight: FontWeight.w700),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: PinCodeTextField(
            controller: widget.controller,
            keyboardType: TextInputType.number,
            animationType: AnimationType.fade,
            textStyle:
                textNormal(AppTheme.getInstance().whiteColor(), 32).copyWith(
              fontWeight: FontWeight.w600,
            ),
            showCursor: false,
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
            animationDuration: const Duration(milliseconds: 100),
            enableActiveFill: true,
            appContext: context,
            length: 6,
            onChanged: (String value) {},
          ),
        ),
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: BlocConsumer<LoginWithEmailCubit, LoginWithEmailState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is TimerCountDown) {
                widget.countDown = state.count;
              } else if (state is TimerEnd) {
                widget.countDown = state.count;
              }
            },
            builder: (context, state) {
              return Text(
                '(${widget.countDown}s)',
                style: textNormal(
                  AppTheme.getInstance().whiteColor(),
                  24,
                ),
              );
            },
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: BlocConsumer<LoginWithEmailCubit, LoginWithEmailState>(
            bloc: cubit,
            listener: (context, state) {
              if (state is TimerEnd) {
                isEnableResend = true;
              }
              if (state is TimerCountDown) {
                isEnableResend = false;
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: isEnableResend
                    ? () {
                        cubit.startTimer(timeStart: startTime);
                      }
                    : null,
                child: Text(
                  S.current.resend_code,
                  style: textNormal(
                    isEnableResend
                        ? AppTheme.getInstance().fillColor()
                        : AppTheme.getInstance().gray3Color(),
                    16,
                  ).copyWith(decoration: TextDecoration.underline),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
