import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PawnshopPackageItem extends StatelessWidget {
  const PawnshopPackageItem({Key? key, required this.pawnshopPackage})
      : super(key: key);
  final PawnshopPackage pawnshopPackage;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        left: 16.w,
        top: 11.h,
        bottom: 12.h,
        right: 12.w,
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
              Container(
                height: 48.h,
                width: 48.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: FadeInImage.assetNetwork(
                  placeholder: ImageAssets.image_loading,
                  imageCacheHeight: 200,
                  placeholderCacheHeight: 50,
                  fit: BoxFit.cover,
                  image: pawnshopPackage.pawnshop?.avatar ?? '',
                  imageErrorBuilder: (context, url, error) {
                    return const SizedBox();
                  },
                ),
              ),
              spaceW8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pawnshopPackage.pawnshop?.name ?? '',
                    style: textNormalCustom(
                      Colors.white,
                      16,
                      FontWeight.w600,
                    ),
                  ),
                  spaceH8,
                  Row(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Image.asset(ImageAssets.img_star),
                      spaceW6,
                      Text(
                        pawnshopPackage.pawnshop?.reputation.toString() ?? '',
                        style: textNormalCustom(
                          Colors.white,
                          14,
                          FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          spaceH10,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Text(
                      'Interest rate',
                      style: textNormalCustom(
                        Colors.white,
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    spaceH3,
                    Text(
                      '${pawnshopPackage.interest}% APR',
                      style: textNormalCustom(
                        Colors.white,
                        20,
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      'Loan type',
                      style: textNormalCustom(
                        Colors.white,
                        14,
                        FontWeight.w600,
                      ),
                    ),
                    spaceH3,
                    typeLoan(),
                  ],
                ),
              ),
            ],
          ),
          spaceH4,
          Text(
            'Collateral accepted',
            style: textNormalCustom(
              Colors.white,
              14,
              FontWeight.w600,
            ),
          ),
          spaceH5,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((pawnshopPackage
                      .acceptableAssetsAsCollateral?.length ??
                      0) <
                      5)
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: pawnshopPackage
                          .acceptableAssetsAsCollateral?.length ??
                          0,
                      itemBuilder: (context, int index) {
                        return Image.asset(
                          ImageAssets.getSymbolAsset(
                            pawnshopPackage
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
                            pawnshopPackage
                                .acceptableAssetsAsCollateral?[index].symbol ??
                                '',
                          ),
                        );
                      },
                    ),
                  if ((pawnshopPackage
                      .acceptableAssetsAsCollateral?.length ??
                      0) >
                      5)
                    Text(
                      '& ${pawnshopPackage.
                      acceptableAssetsAsCollateral!.length - 5} more',
                      style: textNormalCustom(
                        Colors.white,
                        14,
                        FontWeight.w600,
                      ),
                    ),
                ],
              ),
              sizedSvgImage(
                w: 20,
                h: 20,
                image: ImageAssets.ic_bsc_svg,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget typeLoan() {
    if(pawnshopPackage.pawnshop?.type == 0) {
      return Text(
        'Auto',
        style: textNormalCustom(
          blueMarketColor,
          20,
          FontWeight.w600,
        ),
      );
    }
    else {
      return Text(
        'Semi-auto',
        style: textNormalCustom(
          orangeColor,
          20,
          FontWeight.w600,
        ),
      );
    }
  }
}
