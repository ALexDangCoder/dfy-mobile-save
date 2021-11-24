import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TypeIsHaveAmount {
  HAVE_AMOUNT,
  NO_HAVE_AMOUNT,
}

class FormAddFtAmount extends StatelessWidget {
  const FormAddFtAmount({
    this.amount,
    required this.typeForm,
    required this.from,
    required this.to,
    Key? key,
  }) : super(key: key);
  final String from;
  final String to;
  final String? amount;
  final TypeIsHaveAmount typeForm;

  @override
  Widget build(BuildContext context) {
    if(typeForm == TypeIsHaveAmount.HAVE_AMOUNT) {
      return Container(
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
                    spaceH16,
                    Text(
                      '${S.current.to}:',
                      style: textNormalCustom(
                        AppTheme.getInstance().whiteColor(),
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    spaceH16,
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
                spaceW25,
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
                      amount ?? '',
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
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 250.w,
          minHeight: 56.h,
        ),
        child: Container(
          margin: EdgeInsets.only(
            left: 10.w,
            top: 24.h,
            bottom: 20.h,
          ),
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
                  spaceH16,
                  Text(
                    '${S.current.to}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ],
              ),
              spaceW25,
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
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}
