import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/evaluation_hard_nft.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InformationWidget extends StatelessWidget {
  final Evaluation object;

  const InformationWidget({Key? key, required this.object}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.information,
          style: textNormalCustom(
            AppTheme.getInstance().whiteColor(),
            14,
            FontWeight.w600,
          ),
        ),
        spaceH5,
        spaceH12,
        textRow(
            name: S.current.asset_type, value: object.assetType?.name ?? ''),
        textRow(
          name: S.current.authenticity_check,
          value: (object.authenticityType == 1)
              ? S.current.authentic
              : S.current.fake,
        ),
        if (object.properties?.isNotEmpty ?? false)
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: object.properties!.length,
            itemBuilder: (BuildContext context, int index) {
              return textRow(
                name: object.properties![index].traitType ?? '',
                value: object.properties![index].value ?? '',
              );
            },
          ),
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
            child: Text(
              name,
              style: tokenDetailAmount(
                color: AppTheme.getInstance().currencyDetailTokenColor(),
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            width: 24.w,
          ),
          Expanded(
            child: Text(
              value,
              style: tokenDetailAmount(
                color: AppTheme.getInstance().textThemeColor(),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
