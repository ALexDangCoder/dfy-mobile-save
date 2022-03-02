import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalLendingItem extends StatelessWidget {
  const PersonalLendingItem({Key? key, required this.personalLending})
      : super(key: key);

  final PersonalLending personalLending;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        left: 16.w,
        top: 13.h,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: borderItemColors,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: dialogColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                personalLending.name ?? '',
                style: textNormalCustom(
                  Colors.white,
                  16,
                  FontWeight.w600,
                ),
              ),
              spaceW6,
              if (personalLending.isKYC ?? false) ...[
                sizedSvgImage(w: 16, h: 16, image: ImageAssets.ic_verify_svg)
              ]
            ],
          ),
          spaceH8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(ImageAssets.img_star),
              spaceW6,
              Text(
                personalLending.reputation.toString(),
                style: textNormalCustom(
                  Colors.white,
                  14,
                  FontWeight.w600,
                ),
              ),
              spaceW8,
              Container(
                height: 10.h,
                width: 1.w,
                color: Colors.white,
              ),
              spaceW8,
              Text(
                '${personalLending.completedContracts} signed contracts',
                style: textNormalCustom(
                  Colors.white,
                  14,
                  FontWeight.w600,
                ),
              ),
            ],
          ),
          spaceH8,
          Text(
            '${personalLending.minInterestRate} - '
            '${personalLending.maxInterestRate}% Interest rate',
            style: textNormalCustom(
              Colors.white,
              14,
              FontWeight.w600,
            ),
          ),
          spaceH6,
          Text(
            'Collateral accepted',
            style: textNormalCustom(
              Colors.white,
              14,
              FontWeight.w600,
            ),
          ),
          spaceH8,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((personalLending.p2PLenderPackages?[0]
                          .acceptableAssetsAsCollateral?.length ??
                      0) <
                  5)
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: personalLending.p2PLenderPackages?[0]
                          .acceptableAssetsAsCollateral?.length ??
                      0,
                  itemBuilder: (context, int index) {
                    return Image.asset(
                      ImageAssets.getSymbolAsset(
                        personalLending.p2PLenderPackages?[0]
                                .acceptableAssetsAsCollateral?[index].symbol ??
                            '',
                      ),
                    );
                  },
                )
              else
                ListView.builder(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, int index) {
                    return Image.asset(
                      ImageAssets.getSymbolAsset(
                        personalLending.p2PLenderPackages?[0]
                                .acceptableAssetsAsCollateral?[index].symbol ??
                            '',
                      ),
                    );
                  },
                ),
              if ((personalLending.p2PLenderPackages?[0]
                          .acceptableAssetsAsCollateral?.length ??
                      0) >
                  5)
                Text(
                  '& ${personalLending.p2PLenderPackages![0].
                  acceptableAssetsAsCollateral!.length - 5} more',
                  style: textNormalCustom(
                    Colors.white,
                    14,
                    FontWeight.w600,
                  ),
                ),
            ],
          ),
          spaceH20,
          InkWell(
            onTap: (){
              /// Request Loan
            },
            child: ButtonRadial(
              height: 40.h,
              width: 122.w,
              child: Center(
                child: Text(
                  'Request loan',
                  style: textNormalCustom(
                    Colors.white,
                    16,
                    FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
