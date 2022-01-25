import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/presentation/wallet/ui/hero.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'dialog_cancel.dart';

class ItemPawnShop extends StatelessWidget {
  final String avatarPawnShopUrl;
  final String namePawnShop;
  final bool isDeletePawnShop;
  final bool isViewReason;
  final String datePawnShop;
  final String statusPawnShop;

  const ItemPawnShop({
    Key? key,
    required this.avatarPawnShopUrl,
    required this.namePawnShop,
    required this.isDeletePawnShop,
    required this.isViewReason,
    required this.datePawnShop,
    required this.statusPawnShop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 12.w,
      ),
      margin: EdgeInsets.only(
        right: 16.w,
        left: 16.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.r,
          ),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 46.h,
                    width: 46.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      avatarPawnShopUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  spaceW8,
                  Text(
                    namePawnShop,
                    style: textNormalCustom(
                      null,
                      16,
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
              spaceH12,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    ImageAssets.ic_calendar_market,
                    width: 24.w,
                    height: 24.w,
                  ),
                  spaceW15,
                  Text(
                    datePawnShop,
                    style: textNormalCustom(
                      null,
                      20,
                      FontWeight.w600,
                    ),
                  ),
                ],
              ),
              spaceH4,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  statusPawnShop,
                  style: textNormalCustom(
                    checkColor(statusPawnShop),
                    12,
                    null,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              spaceH8,
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  child: isViewReason
                      ? InkWell(
                          onTap: () {
                            // todo add even vào đây
                          },
                          child: Text(
                            S.current.view_reason,
                            style: textNormalCustom(
                              null,
                              12,
                              null,
                            ).copyWith(decoration: TextDecoration.underline),
                            textAlign: TextAlign.end,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
          Positioned(
            top: -4.h,
            right: -4.w,
            child: isDeletePawnShop
                ? InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        HeroDialogRoute(
                          builder: (context) {
                            return const DialogCancel();
                          },
                          isNonBackground: false,
                        ),
                      );
                    },
                    child: Image.asset(
                      ImageAssets.imgCancelMarket,
                      width: 20.w,
                      height: 20.h,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Color checkColor(String status) {
    if (S.current.your_appointment_request == status) {
      return AppTheme.getInstance().orangeMarketColors();
    } else if (S.current.the_evaluator_has_rejected == status) {
      return AppTheme.getInstance().redMarketColors();
    } else if (S.current.the_evaluator_has_accepted == status) {
      return AppTheme.getInstance().greenMarketColors();
    } else if (S.current.evaluator_has_suggested == status) {
      return AppTheme.getInstance().blueMarketColors();
    } else {
      return AppTheme.getInstance().redMarketColors();
    }
  }
}
