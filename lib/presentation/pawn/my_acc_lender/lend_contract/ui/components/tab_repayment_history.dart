import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatValueUSD = NumberFormat('\$ ###,###,###.###', 'en_US');

class TabRepaymentHistory extends StatelessWidget {
  const TabRepaymentHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 151.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return _itemTotal(
                titleTotal: 'Total loan',
                priceTotal: 100009990.99,
                typeTotal: 2,
              );
            },
          ),
        ),
        spaceH20,
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return _itemRepaymentHistory();
            },
          ),
        ),
        // spaceH32,
      ],
    );
  }

  Widget _itemRepaymentHistory() {
    return Container(
      width: 343.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().colorTextReset(),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        border: Border.all(
          color: AppTheme.getInstance().fillColor(),
        ),
      ),
      margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 8.h, bottom: 8.h),
            child: Column(
              children: [
                _rowItem(
                  title: S.current.cycle.withColon(),
                  description: Text(
                    '4',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceH16,
                _rowItem(
                  title: S.current.due_to_gmt.withColon(),
                  description: Text(
                    '12:00  31/03/2021',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteColor(),
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceH16,
                _rowItem(
                  title: S.current.penalty.withColon(),
                  description: Row(
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: Image.network(
                          ImageAssets.getUrlToken(DFY),
                        ),
                      ),
                      spaceW8,
                      Text(
                        '0',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                spaceH16,
                _rowItem(
                  title: S.current.interest.withColon(),
                  description: Row(
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: Image.network(
                          ImageAssets.getUrlToken(DFY),
                        ),
                      ),
                      spaceW8,
                      Text(
                        '0',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                spaceH16,
                _rowItem(
                  title: S.current.loan.withColon(),
                  description: Row(
                    children: [
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: Image.network(
                          ImageAssets.getUrlToken(DFY),
                        ),
                      ),
                      spaceW8,
                      Text(
                        'BNB 0/50',
                        style: textNormalCustom(
                          AppTheme.getInstance().whiteColor(),
                          16,
                          FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
                spaceH16,
                _rowItem(
                  title: S.current.status.withColon(),
                  description: Text(
                    'Wait payment',
                    style: textNormalCustom(
                      AppTheme.getInstance().orangeMarketColors(),
                      16,
                      FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _rowItem({
    required String title,
    required Widget description,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: textNormalCustom(
              AppTheme.getInstance().pawnItemGray(),
              16,
              FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: description,
        ),
      ],
    );
  }

  Widget _itemTotal({
    required String titleTotal,
    required double priceTotal,
    required int typeTotal,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 16.w),
      margin: EdgeInsets.only(
        left: 16.w,
      ),
      width: 151.w,
      height: 121.h,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(ImageAssets.bg_repayment_history),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(
            16.r,
          ),
        ),
        border: Border.all(color: getColorPriceTotal(typeTotal: typeTotal)),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8.h,
            child: Text(
              titleTotal,
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            bottom: 15.h,
            child: Text(
              formatValueUSD.format(priceTotal).handleTitle(),
              style: textNormalCustom(
                getColorPriceTotal(typeTotal: typeTotal),
                18,
                FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Color getColorPriceTotal({required int typeTotal}) {
    switch (typeTotal) {
      case 1:
        return AppTheme.getInstance().successTransactionColors();
      case 2:
        return AppTheme.getInstance().blueColor();
      default:
        return AppTheme.getInstance().redMarketColors();
    }
  }
}
