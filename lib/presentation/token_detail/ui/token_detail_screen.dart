import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/text_helper.dart';
import 'package:Dfy/widgets/views/default_sub_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class TokenDetailScreen extends StatelessWidget {
  final int tokenData;

  const TokenDetailScreen({Key? key, required this.tokenData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultSubScreen(
      title: 'DFY',
      mainWidget: Column(
        children: [
          SizedBox(
            height: 308.h,
            child: Column(
              children: [
                SizedBox(
                  height: 54.h,
                  width: 54.h,
                  child: Image.asset(
                    ImageAssets.symbol,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  '${detailCurrencyFormat.format(double.parse('12312.123213123'))} DFY',
                  style: tokenDetailAmount(
                    color: AppTheme.getInstance().textThemeColor(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
