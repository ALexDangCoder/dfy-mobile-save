import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PawnItem extends StatelessWidget {
  const PawnItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 343.w,
        padding: EdgeInsets.only(
          left: 16.w,
          bottom: 24.h,
          right: 16.w,
          top: 16.h,
        ),
        decoration: BoxDecoration(
          color: AppTheme.getInstance().borderItemColor(),
          borderRadius: BorderRadius.all(
            Radius.circular(20.r),
          ),
          border: Border.all(
            color: AppTheme.getInstance().divideColor(),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              8.r,
                            ),
                          ),
                        ),
                        child: Image.network(
                          'https://ecdn.game4v.com/g4v-content/uploads/2022/01/01103009/OP-2021-02-game4v-1641007807-80.png',
                          width: 99.w,
                          height: 99.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 4.h,
                        left: 4.w,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://sportshub.cbsistatic.com/i/2021/03/18/6eab5e5f-ca8c-42d1-862d-2df903b5309c/one-piece-wano-luffy-cosplay-1252700.jpg',
                            width: 20.w,
                            height: 20.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                spaceW12,
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'QQ’s Pawn sdfgdfsgdfs gfdsgdshop',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w600,
                          ).copyWith(
                            overflow: TextOverflow.clip,
                          ),
                          children: [
                            WidgetSpan(
                              child: spaceW6,
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Image.asset(ImageAssets.ic_selected),
                            ),
                          ],
                        ),
                      ),
                      spaceH12,
                      RichText(
                        text: TextSpan(
                          text: '',
                          style: textNormalCustom(
                            null,
                            16,
                            FontWeight.w600,
                          ).copyWith(
                            overflow: TextOverflow.clip,
                          ),
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Image.asset(ImageAssets.img_star),
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: spaceW6,
                            ),
                            TextSpan(text: '1000'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            spaceH12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.collateral_accepted}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: textNormalCustom(
                        null,
                        14,
                        FontWeight.w400,
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        TextSpan(text: '& 20 more'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            spaceH12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.collateral_accepted}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: '',
                      style: textNormalCustom(
                        null,
                        14,
                        FontWeight.w400,
                      ),
                      children: [
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Image.asset(
                            ImageAssets.ic_selected,
                            height: 16.w,
                            width: 16.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            spaceH12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.available_loan_package}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '12',
                    style: textNormalCustom(
                      null,
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            spaceH12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.interest_rate_from}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${S.current.interest_rate_from}:',
                    style: textNormalCustom(
                      null,
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            spaceH12,
            line,
            spaceH12,
            Align(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  text: '135.478  ',
                  style: textNormalCustom(
                    null,
                    24,
                    FontWeight.w600,
                  ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Image.asset(
                        ImageAssets.img_waning,
                        height: 20.w,
                        width: 20.w,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            spaceH24,
            Center(
              child: GestureDetector(
                onTap: () {
                  //todo event
                },
                child: SizedBox(
                  width: 140.w,
                  height: 40.h,
                  child: ButtonGold(
                    radiusButton: 16,
                    haveMargin: false,
                    title: S.current.view_pawnshop,
                    isEnable: true,
                    fixSize: false,
                    textSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
