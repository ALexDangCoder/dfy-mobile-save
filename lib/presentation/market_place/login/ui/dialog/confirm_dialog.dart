import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmDialog extends StatelessWidget {
  final String content;
  final String contentLeftButton;
  final String contentRightButton;
  final Function() onRightBtnClick;

  const ConfirmDialog(
      {Key? key,
      required this.content,
      required this.contentLeftButton,
      required this.contentRightButton,
      required this.onRightBtnClick})
      : super(key: key);

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
                      content,
                      textAlign: TextAlign.center,
                      style: textNormal(
                        AppTheme.getInstance().whiteColor(),
                        20.sp,
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
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
                                    .whiteBackgroundButtonColor()),
                          )),
                          child: GestureDetector(
                            onTap: () => Navigator.pop(context),
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 19,
                                top: 17,
                              ),
                              child: Text(
                                contentLeftButton,
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
                                    .whiteBackgroundButtonColor()),
                            left: BorderSide(
                                width: 1.w,
                                color: AppTheme.getInstance()
                                    .whiteBackgroundButtonColor()),
                          )),
                          child: GestureDetector(
                            onTap: () {
                               onRightBtnClick();
                               Navigator.pop(context);
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 19,
                                top: 17,
                              ),
                              child: Text(
                                contentRightButton,
                                style: textNormal(
                                  AppTheme.getInstance().fillColor(),
                                  20.sp,
                                ).copyWith(fontWeight: FontWeight.w700),
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
