import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/locals/prefs_service.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/bloc/login_with_email_cubit.dart';
import 'package:Dfy/presentation/market_place/login/login_with_email/ui/enter_email_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectEmailDialog extends StatefulWidget {
  /// The screen you want navigator to if user  has login
  final Widget navigationTo;

  const ConnectEmailDialog({
    Key? key,
    required this.navigationTo,
  }) : super(key: key);

  @override
  State<ConnectEmailDialog> createState() => _ConnectEmailDialogState();
}

class _ConnectEmailDialogState extends State<ConnectEmailDialog> {
  late final LoginWithEmailCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = LoginWithEmailCubit();
  }

  @override
  void dispose() {
    super.dispose();
    cubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: () {},
          child: Center(
            child: Container(
              constraints: BoxConstraints(minHeight: 177.h),
              width: 312.w,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().bgBtsColor(),
                borderRadius: const BorderRadius.all(Radius.circular(36)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      top: 32,
                      right: 42.5,
                      bottom: 24,
                      left: 41.5,
                    ),
                    child: Text(
                      S.current.associate_email,
                      textAlign: TextAlign.center,
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        20.sp,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 16.w,
                      ),
                      StreamBuilder<bool>(
                          stream: cubit.isCheckedCheckBoxStream,
                          builder: (context, snapshot) {
                            return Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                fillColor: MaterialStateProperty.all(
                                    const Color(0xffE4AC1A)),
                                activeColor:
                                    const Color.fromRGBO(228, 172, 26, 1),
                                // checkColor: const Colors,
                                onChanged: (value) {
                                  cubit.setCheckboxValue();
                                },
                                value: cubit.isCheckedCheckboxSubject.value,
                              ),
                            );
                          }),
                      Text(
                        S.current.dont_ask_again,
                        style: textNormal(
                          AppTheme.getInstance().whiteColor(),
                          16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1.w,
                                color: AppTheme.getInstance()
                                    .whiteBackgroundButtonColor(),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              PrefsService.saveOptionShowDialogConnectEmail(
                                !cubit.isCheckedCheckboxSubject.value,
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => widget.navigationTo,
                                ),
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 19,
                                top: 17,
                              ),
                              child: Text(
                                S.current.no_continue,
                                style: textNormal(
                                  AppTheme.getInstance().whiteColor(),
                                  20.sp,
                                ).copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                width: 1.w,
                                color: AppTheme.getInstance()
                                    .whiteBackgroundButtonColor(),
                              ),
                              left: BorderSide(
                                width: 1.w,
                                color: AppTheme.getInstance()
                                    .whiteBackgroundButtonColor(),
                              ),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              PrefsService.saveOptionShowDialogConnectEmail(
                                !cubit.isCheckedCheckboxSubject.value,
                              );
                              //ví chưa liên kết email
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EnterEmail(),
                                ),
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 19,
                                top: 17,
                              ),
                              child: Text(
                                S.current.yes,
                                style: textNormal(
                                  AppTheme.getInstance().fillColor(),
                                  20.sp,
                                ).copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
