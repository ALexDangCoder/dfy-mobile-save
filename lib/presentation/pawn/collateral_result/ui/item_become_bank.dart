import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemBecomeBank extends StatelessWidget {
  const ItemBecomeBank({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().pawnItemColor(),
        borderRadius: BorderRadius.all(
          Radius.circular(8.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              padding: EdgeInsets.only(
                top: 28.h,
                left: 12.w,
                right: 12.w,
                bottom: 24.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.current.become_your_own_bank,
                    style: textNormalCustom(
                      AppTheme.getInstance().yellowColor(),
                      16,
                      FontWeight.w600,
                    ),
                  ),
                  spaceH10,
                  RichText(
                    text: TextSpan(
                      text: '${S.current.sign_up_for_pawnshop_to_get_great} ',
                      style: textNormal(
                        null,
                        12,
                      ),
                      children: [
                        TextSpan(
                          text: S.current.de_fi,
                          style: textNormal(
                            AppTheme.getInstance().yellowColor(),
                            12,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(flex: 4, child: Image.asset(ImageAssets.img_money_increase)),
        ],
      ),
    );
  }
}
