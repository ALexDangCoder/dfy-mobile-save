import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/borrow_available_collateral.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/app_constants.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignedContractItem extends StatelessWidget {
  const SignedContractItem({Key? key, required this.signedContractUser}) : super(key: key);
  final SignedContractUser signedContractUser;
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
                  '${S.current.collateral}:',
                  style: textNormal(grey3, 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    if (signedContractUser.nftCollateral == null) ...[
                      SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: FadeInImage.assetNetwork(
                          placeholder: '',
                          image: ImageAssets.getUrlToken(
                            signedContractUser.collateralSymbol ?? '',
                          ),
                          placeholderErrorBuilder: (ctx,obj,st){
                            return const SizedBox();
                          },
                          imageErrorBuilder: (ctx,obj,st){
                            return const SizedBox();
                          },
                        ),
                      ),
                      spaceW8,
                    ],
                    Text(
                      signedContractUser.nftCollateral != null
                          ? NFT
                          : '${signedContractUser.collateralAmount} ${signedContractUser.collateralSymbol}',
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
                  '${S.current.loan_token}:',
                  style: textNormal(grey3, 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: FadeInImage.assetNetwork(
                        placeholder: '',
                        image: ImageAssets.getUrlToken(
                          signedContractUser.loanSymbol ?? '',
                        ),
                        placeholderErrorBuilder: (ctx,obj,st){
                          return const SizedBox();
                        },
                        imageErrorBuilder: (ctx,obj,st){
                          return const SizedBox();
                        },
                      ),
                    ),
                    spaceW8,
                    Text(
                      '${signedContractUser.loanSymbol}',
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
              Text(
                '${S.current.interest_rate_apr}:',
                style: textNormal(grey3, 16),
              ),
              spaceW8,
              Text(
                '${signedContractUser.interestRate}%',
                style: textNormal(Colors.white, 16),
              ),
            ],
          ),
          spaceH16,
          Row(
            children: [
              Expanded(
                child: Text(
                  S.current.duration,
                  style: textNormal(grey3, 16),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  '${signedContractUser.durationQty} '
                      '${signedContractUser.durationQty == 0 ? S.current.week : S.current.month}',
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
