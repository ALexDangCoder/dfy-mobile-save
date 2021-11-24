import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class InformationWidget extends StatelessWidget {
  final String object;

  const InformationWidget({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.information,
          style: tokenDetailAmount(
            color: AppTheme.getInstance().whiteColor(),
            fontSize: 14,
          ),
        ),
        spaceH5,
        spaceH12,
        textRow(name: S.current.evaluated_by, value: 'Annette Black'),
        textRow(name: S.current.asset_type, value: 'Car'),
        textRow(name: S.current.authenticity_check, value: 'Authenic'),
        textRow(name: S.current.carat, value: '400 ct'),
        textRow(name: S.current.clarity, value: 'Flawless'),
        textRow(name: S.current.shape, value: 'Oval'),
        textRow(name: S.current.cut_grade, value: 'Oval'),
      ],
    );
  }

  Widget textRow({
    required String name,
    required String value,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              name,
              style: tokenDetailAmount(
                color: AppTheme.getInstance().currencyDetailTokenColor(),
                weight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
            Expanded(
              flex: 9,
              child: Text(
                value,
                style: tokenDetailAmount(
                  color: AppTheme.getInstance().textThemeColor(),
                  fontSize: 14,
                  weight: FontWeight.w400,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
