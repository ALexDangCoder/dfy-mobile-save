import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/extensions/string_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

final formatValue = NumberFormat('###,###,###.###', 'en_US');

class LenderLoanRequestNftItem extends StatelessWidget {
  const LenderLoanRequestNftItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 12.h,
        bottom: 12.h,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppTheme.getInstance().divideColor(),
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
        color: AppTheme.getInstance().bgBtsColor(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _imageFtNameNft(),
          spaceH12,
          _rowItem(
            title: S.current.borrower.capitalize(),
            description: Text(
              '0x723....0238',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ).copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          spaceH12,
          _rowItem(
            title: S.current.duration.capitalize(),
            description: Text(
              '12 months',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ),
            ),
          ),
          spaceH12,
          _rowItem(
            title: S.current.asset_location.capitalize(),
            description: Text(
              '4517 Washington Ave. Manchester, Kentucky 39495',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ),
            ),
          ),
          spaceH12,
          _rowItem(
            title: S.current.status.capitalize(),
            description: Text(
              'open',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                14,
                FontWeight.w400,
              ),
            ),
          ),
          spaceH16,
          Container(
            height: 1.h,
            color: AppTheme.getInstance().divideColor(),
          ),
          spaceH16,
          _rowItem(
            title: S.current.expected_loan.capitalize(),
            description: Text(
              '${formatValue.format(100000000)} USDT',
              style: textNormalCustom(
                AppTheme.getInstance().whiteColor(),
                24,
                FontWeight.w600,
              ),
            ),
          )
        ],
      ),
    );
  }

  Row _imageFtNameNft({
    bool? isHardNft = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: Image.network(ImageAssets.getUrlToken('DFY')),
              ),
              if (isHardNft ?? false)
                Positioned(
                  top: 0.h,
                  right: 7.w,
                  child: const Image(
                    image: AssetImage(ImageAssets.img_hard_nft),
                  ),
                )
              else
                Container()
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The lonely tree',
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  16,
                  FontWeight.w600,
                ),
              ),
              spaceH8,
              Row(
                children: [
                  Text(
                    'BDA collection',
                    style: textNormalCustom(
                      AppTheme.getInstance().whiteWithOpacitySevenZero(),
                      14,
                      FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Row _rowItem({
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
          flex: 6,
          child: description,
        )
      ],
    );
  }
}
