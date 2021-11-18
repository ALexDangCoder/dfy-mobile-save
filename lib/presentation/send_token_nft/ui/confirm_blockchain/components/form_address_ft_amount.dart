import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormAddFtAmount extends StatelessWidget {
  const  FormAddFtAmount({
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
    return Container(
      // height: 93.h,
      margin: EdgeInsets.only(
        left: 10.w,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${S.current.from}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
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
                        16,
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
                        16,
                        FontWeight.w400,
                      ),
                    )
                  ],
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
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Text(
                      to,
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
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
                        20,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),

            ],
          ),
        ),
      ),
    );
  }
}
