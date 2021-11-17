import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormAddFtAmount extends StatelessWidget {
  const FormAddFtAmount({
    required this.amount,
    required this.from,
    required this.to,
    Key? key,
  }) : super(key: key);
  final String from;
  final String to;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 26.w,
        right: 99.w,
        top: 24.h,
        bottom: 20.h,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 250.w,
          minHeight: 93.h,
        ),
        child: SizedBox(
          // width: 250.w,
          // height: 93.h,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${S.current.from}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16.sp,
                        FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Text(
                      '${S.current.to}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16.sp,
                        FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    Text(
                      '${S.current.amount}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16.sp,
                        FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 30.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    from,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16.sp,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Text(
                    to,
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16.sp,
                      FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 18.h,
                  ),
                  Text(
                    amount,
                    style: textNormalCustom(
                      AppTheme.getInstance().fillColor(),
                      20.sp,
                      FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
