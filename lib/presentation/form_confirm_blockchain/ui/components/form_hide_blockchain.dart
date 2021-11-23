import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormHideCfBlockchain extends StatelessWidget {
  const FormHideCfBlockchain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        top: 8.h,
        left: 16.w,
        right: 16.w,
        bottom: 10.h,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //todo handle when insufficient gas fee
              Text(
                S.current.estimate_gas_fee,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
            ],
          ),
          spaceH3,
          Text(
            S.current.customize_fee,
            style: textNormalCustom(
              const Color.fromRGBO(70, 188, 255, 1),
              14,
              FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
