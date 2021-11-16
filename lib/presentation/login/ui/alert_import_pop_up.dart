import 'dart:ui';

import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/restore_bts/ui/restore_bts.dart';
import 'package:Dfy/utils/animate/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertPopUp extends StatelessWidget {
  const AlertPopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Hero(
        tag: '',
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin!, end: end!);
        },
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 2.0, sigmaX: 2.0),
          child: Material(
            color: AppTheme.getInstance().selectDialogColor(),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
            child: SizedBox(
              width: 312.w,
              height: 300.h,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      right: 20.w,
                      left: 20.w,
                      bottom: 20.h,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 3,
                            top: 4,
                            right: 3,
                          ),
                          child: Text(
                            S.current.are_you_sure,
                            textAlign: TextAlign.center,
                            style: textNormal(
                              AppTheme.getInstance().wrongColor(),
                              20.sp,
                            ).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        Text(
                          S.current.your_current_wallet,
                          textAlign: TextAlign.center,
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            12.sp,
                          ).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 11.h,
                        ),
                        Text(
                          S.current.you_can_only,
                          textAlign: TextAlign.center,
                          style: textNormal(
                            AppTheme.getInstance().whiteColor(),
                            12.sp,
                          ).copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 61.h,
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: Colors.white,
                          width: 0.2,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: SizedBox(
                              width: 156.w,
                              child: Center(
                                child: Text(
                                  S.current.cancel,
                                  style: textNormal(null, 20.sp).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(),
                        Flexible(
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) => const RestoreBTS(),
                              ).then((value) => Navigator.pop(context));
                            },
                            child: SizedBox(
                              width: 156.w,
                              child: Center(
                                child: Text(
                                  S.current.continue_s,
                                  style: textNormal(
                                    AppTheme.getInstance().wrongColor(),
                                    20.sp,
                                  ).copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                  ),
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
    );
  }
}
