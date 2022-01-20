import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/ui/custom_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogCancel extends StatelessWidget {
  const DialogCancel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 1.0, sigmaX: 1.0),
        child: Center(
          child: Center(
            child: Hero(
              tag: '',
              createRectTween: (begin, end) {
                return CustomRectTween(begin: begin!, end: end!);
              },
              child: Material(
                color: AppTheme.getInstance().selectDialogColor(),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(36.r),
                ),
                child: SizedBox(
                  width: 312.w,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 24.h,
                          left: 26.w,
                          right: 26.w,
                          top: 21.h,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            S.current.cancel_appointment,
                            style: textNormalCustom(
                              null,
                              24,
                              FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: 26.w,
                          right: 26.w,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: S.current.your_appointment_with,
                            style: textNormalCustom(
                              null,
                              14,
                              null,
                            ),
                            children: [
                              TextSpan(
                                text: S.current.evaluator_tima_online,
                                style: textNormalCustom(
                                  AppTheme.getInstance().yellowColor(),
                                  14,
                                  FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text: S.current.pawnshop_will_be_rejected,
                              ),
                            ],
                          ),
                        ),
                      ),
                      spaceH32,
                      Container(
                        height: 64.h,
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: AppTheme.getInstance().divideColor(),
                              width: 1.h,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  //todo event
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 64.h,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: AppTheme.getInstance()
                                            .divideColor(),
                                        width: 1.h,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      S.current.cancel,
                                      style: textNormal(null, 20.sp).copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  //todo event
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  height: 64.h,
                                  child: Center(
                                    child: Text(
                                      S.current.cancel_appointment,
                                      style: textNormal(
                                        const Color(0xffE4AC1A),
                                        20,
                                      ).copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
