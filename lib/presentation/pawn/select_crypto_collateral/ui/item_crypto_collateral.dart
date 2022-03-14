import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/crypto_collateral.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/button/error_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCryptoCollateral extends StatelessWidget {
  const ItemCryptoCollateral({Key? key, required this.model}) : super(key: key);

  final CryptoCollateralModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        left: 16.w,
        top: 13.h,
        right: 16.w,
      ),
      decoration: BoxDecoration(
        color: borderItemColors,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: dialogColor),
      ),
      child: Column(
        children: [
          _row(
            'Name:',
            Text(
              model.name ?? '',
              style: textNormalCustom(
                Colors.white,
                14,
                FontWeight.w600,
              ),
            ),
          ),
          spaceH16,
          _row(
            'Collateral',
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: Image.asset(
                    ImageAssets.getSymbolAsset(
                      model.collateralSymbol ?? '',
                    ),
                  ),
                ),
                spaceW8,
                Text(
                  '${model.collateralAmount} ${model.collateralSymbol}',
                  style: textNormalCustom(
                    Colors.white,
                    14,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          spaceH16,
          _row(
            'Loan token',
            Row(
              children: [
                SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: Image.asset(
                    ImageAssets.getSymbolAsset(
                      model.loanTokenSymbol ?? '',
                    ),
                  ),
                ),
                spaceW8,
                Text(
                  '${model.loanTokenSymbol}',
                  style: textNormalCustom(
                    Colors.white,
                    14,
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          spaceH16,
          _row(
            'Duration',
            Text(
              '${model.duration} ${(model.durationType == 0) ? S.current.week : S.current.month}',
              style: textNormalCustom(
                Colors.white,
                14,
                FontWeight.w600,
              ),
            ),
          ),
          spaceH20,
          InkWell(
            onTap: () {
             if(model.isSelect == true) {
               Navigator.pop(context, model);
             }
            },
            child: (model.isSelect == true)
                ? ButtonRadial(
                    height: 40.h,
                    width: 100.w,
                    child: Center(
                      child: Text(
                        'Select',
                        style: textNormalCustom(
                          Colors.white,
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                : ErrorButton(
                    height: 40.h,
                    width: 100.w,
                    child: Center(
                      child: Text(
                        'Select',
                        style: textNormalCustom(
                          Colors.white,
                          16,
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
          ),
          spaceH20,
        ],
      ),
    );
  }

  Widget _row(String title, Widget widget) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: textNormalCustom(
              grey3,
              14,
              FontWeight.w400,
            ),
          ),
        ),
        Expanded(flex: 3, child: widget),
      ],
    );
  }
}
