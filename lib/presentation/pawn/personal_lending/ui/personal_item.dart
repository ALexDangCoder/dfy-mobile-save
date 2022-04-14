import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/pawn/borrow_result/ui/pawnshop_package_item.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/send_loan_requet.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:Dfy/widgets/common/info_popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalItem extends StatelessWidget {
  final String nameShop;
  final bool isShop;
  final String rate;
  final List<AcceptableAssetsAsCollateral> collateral;
  final String interestRate;
  final String signedContract;
  final String total;
  final String id;
  final int type;

  const PersonalItem({
    Key? key,
    required this.nameShop,
    required this.isShop,
    required this.rate,
    required this.collateral,
    required this.interestRate,
    required this.signedContract,
    required this.total,
    required this.id, required this.type,
  }) : super(key: key);

  WidgetSpan widgetSpanBase({
    required int listLength,
    required int maxLength,
    required String symbol,
  }) {
    return WidgetSpan(
      alignment: PlaceholderAlignment.middle,
      child: listLength >= maxLength
          ? Image.network(
              ImageAssets.getSymbolAsset(
                symbol,
              ),
              height: 16.w,
              width: 16.w,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 16.w,
                width: 16.w,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().bgBtsColor(),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    symbol.substring(0, 1),
                    style: textNormalCustom(
                      null,
                      12,
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }

  WidgetSpan widgetSpanSpaceW2() {
    return WidgetSpan(
      child: spaceW2,
    );
  }

  WidgetSpan widgetTextSpan(
      {required int listLength,
      required List<String> listToken,
      required BuildContext context}) {
    return WidgetSpan(
      child: GestureDetector(
        onTap: () {
          showInfo(
            context,
            listToken,
          );
        },
        child: Text(
          listLength > 5
              ? '& ${listLength - 5} '
                      '${S.current.more}'
                  .toLowerCase()
              : '',
          style: textNormalCustom(
            null,
            14,
            FontWeight.w400,
          ),
        ),
      ),
    );
  }

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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 8,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SendLoanRequest(
                              packageId: id,
                              pawnshopType: '3',
                              collateralAccepted: collateral, type: type,
                            );
                          },
                        ),
                      );
                    },
                    child: RichText(
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
                  ),
                ),
                spaceH12,
                Expanded(
                  flex: 2,
                  child: RichText(
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
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Text(
                            rate,
                            style: textNormal(
                              null,
                              16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            spaceH12,
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${S.current.interest_rate_apr}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceW4,
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                spaceW4,
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
                        widgetSpanBase(
                          listLength: collateral.length,
                          maxLength: 1,
                          symbol: collateral.isNotEmpty
                              ? collateral[0].symbol?.toUpperCase() ?? ''
                              : '',
                        ),
                        widgetSpanSpaceW2(),
                        widgetSpanBase(
                          symbol: collateral.length >= 2
                              ? collateral[1].symbol?.toUpperCase() ?? ''
                              : '',
                          listLength: collateral.length,
                          maxLength: 2,
                        ),
                        widgetSpanSpaceW2(),
                        widgetSpanBase(
                          symbol: collateral.length >= 3
                              ? collateral[2].symbol?.toUpperCase() ?? ''
                              : '',
                          listLength: collateral.length,
                          maxLength: 3,
                        ),
                        widgetSpanSpaceW2(),
                        widgetSpanBase(
                          symbol: collateral.length >= 4
                              ? collateral[3].symbol?.toUpperCase() ?? ''
                              : '',
                          listLength: collateral.length,
                          maxLength: 4,
                        ),
                        widgetSpanSpaceW2(),
                        widgetSpanBase(
                          symbol: collateral.length >= 5
                              ? collateral[4].symbol?.toUpperCase() ?? ''
                              : '',
                          listLength: collateral.length,
                          maxLength: 5,
                        ),
                        widgetSpanSpaceW2(),
                        widgetTextSpan(
                          listLength: collateral.length,
                          listToken: collateral
                              .map((e) => e.symbol.toString())
                              .toList(),
                          context: context,
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
                    '${S.current.sign_contract_pawn}:',
                    style: textNormalCustom(
                      AppTheme.getInstance().pawnGray(),
                      14,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceW4,
                Expanded(
                  child: Text(
                    formatPrice.format(double.parse(signedContract)),
                    style: textNormalCustom(
                      null,
                      14,
                      FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
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
                  text: '',
                  style: textNormalCustom(
                    null,
                    24,
                    FontWeight.w600,
                  ),
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Text(
                        '\$ ${formatPrice.format(double.parse(total))}  ',
                        style: textNormalCustom(
                          null,
                          24,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => InfoPopup(
                              name: S.current.total_contract_value,
                              content: S.current.total_value_of_all,
                            ),
                          );
                        },
                        child: Image.asset(
                          ImageAssets.img_waning,
                          height: 20.w,
                          width: 20.w,
                        ),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return SendLoanRequest(
                          packageId: id,
                          pawnshopType: '3',
                          collateralAccepted: collateral, type: type,
                        );
                      },
                    ),
                  );
                },
                child: SizedBox(
                  width: 140.w,
                  height: 40.h,
                  child: ButtonGold(
                    radiusButton: 12,
                    haveMargin: false,
                    title: S.current.request_loan,
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
