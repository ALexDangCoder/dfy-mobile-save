import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AvailableCollateralItem extends StatelessWidget {
  const AvailableCollateralItem({Key? key, required this.collateralUser})
      : super(key: key);
  final CollateralUser collateralUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        left: 16.w,
        top: 16.h,
        bottom: 20.h,
        right: 12.w,
      ),
      decoration: BoxDecoration(
        color: borderItemColors,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: dialogColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Collateral:',
                  style: textNormal(grey3, 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    if (collateralUser.nftCollateral == null) ...[
                      Image.asset(
                        ImageAssets.getUrlToken(
                          collateralUser.collateralSymbol ?? '',
                        ),
                      ),
                      spaceH8,
                    ],
                    Text(
                      collateralUser.nftCollateral != null
                          ? NFT
                          : '${collateralUser.collateralAmount} ${collateralUser.collateralSymbol}',
                      style: textNormal(Colors.white, 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          spaceH16,
          Row(
            children: [
              Expanded(
                child: Text(
                  'Loan token:',
                  style: textNormal(grey3, 16),
                ),
              ),
              spaceH8,
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.getUrlToken(
                        collateralUser.loanSymbol ?? '',
                      ),
                    ),
                    Text(
                      '${collateralUser.collateralSymbol}',
                      style: textNormal(Colors.white, 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
          spaceH16,
          Row(
            children: [
              Expanded(
                child: Text(
                  'Duration:',
                  style: textNormal(grey3, 16),
                ),
              ),
              spaceH8,
              Expanded(
                flex: 2,
                child: Text(
                  '${collateralUser.durationQty} '
                      '${collateralUser.durationQty == 0 ? S.current.week : S.current.month}',
                  style: textNormal(Colors.white, 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
