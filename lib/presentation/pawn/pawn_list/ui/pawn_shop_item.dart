import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/token_model_pawn.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PawnItem extends StatelessWidget {
  final String imageAvatar;
  final String imageCover;
  final String nameShop;
  final bool isShop;
  final String rate;
  final List<TokenModelPawn> collateral;
  final List<TokenModelPawn> loadToken;
  final String interestRate;
  final String availableLoan;
  final String total;

  const PawnItem({
    Key? key,
    required this.imageAvatar,
    required this.imageCover,
    required this.nameShop,
    required this.isShop,
    required this.rate,
    required this.collateral,
    required this.loadToken,
    required this.interestRate,
    required this.availableLoan,
    required this.total,
  }) : super(key: key);

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
        margin: EdgeInsets.only(
          bottom: 20.h,
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
                          imageCover,
                          width: 99.w,
                          height: 99.w,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: AppTheme.getInstance().bgBtsColor(),
                          ),
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
                            imageAvatar,
                            width: 20.w,
                            height: 20.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: AppTheme.getInstance().bgBtsColor(),
                              width: 20.w,
                              height: 20.w,
                            ),
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
                          text: nameShop,
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
                              child: isShop
                                  ? Image.asset(ImageAssets.ic_selected)
                                  : const SizedBox.shrink(),
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
                            TextSpan(text: rate),
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
                          child: collateral.isNotEmpty
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    collateral[0].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: collateral.length >= 2
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    collateral[1].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: collateral.length >= 3
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    collateral[2].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: collateral.length >= 4
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    collateral[3].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: collateral.length >= 5
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    collateral[4].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        TextSpan(
                          text: collateral.length > 5
                              ? '& ${collateral.length - 5} '
                                      '${S.current.more}'
                                  .toLowerCase()
                              : '',
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
                          child: loadToken.isNotEmpty
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    loadToken[0].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: loadToken.length > 1
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    loadToken[1].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: loadToken.length > 2
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    loadToken[2].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: loadToken.length > 3
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    loadToken[3].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: loadToken.length > 4
                              ? Image.asset(
                                  ImageAssets.getSymbolAsset(
                                    loadToken[4].symbol?.toUpperCase() ?? '',
                                  ),
                                  height: 16.w,
                                  width: 16.w,
                                )
                              : const SizedBox.shrink(),
                        ),
                        WidgetSpan(
                          child: spaceW2,
                        ),
                        TextSpan(
                          text: loadToken.length > 5
                              ? '& ${loadToken.length - 5} '
                                      '${S.current.more}'
                                  .toLowerCase()
                              : '',
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
                    availableLoan,
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
                    interestRate,
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
                  text: '\$ $total  ',
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
