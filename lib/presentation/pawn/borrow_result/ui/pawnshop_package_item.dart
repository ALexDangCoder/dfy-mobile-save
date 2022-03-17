import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/presentation/pawn/loan_package_detail/ui/loan_package_detail.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/utils/screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PawnshopPackageItem extends StatelessWidget {
  const PawnshopPackageItem({Key? key, required this.pawnshopPackage})
      : super(key: key);
  final PawnshopPackage pawnshopPackage;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goTo(
          context,
          LoanPackageDetail(
            packageId: pawnshopPackage.id.toString(),
            packageType: pawnshopPackage.type ?? 0,
          ),
        );
      },
      child: Container(
        width: 343.w,
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
                  clipBehavior: Clip.hardEdge,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(ImageAssets.img_star),
                        spaceW6,
                        Text(
                          pawnshopPackage.pawnshop?.reputation.toString() ?? '',
                          style: textNormalCustom(
                            Colors.white,
                            14,
                            FontWeight.w400,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interest rate',
                        style: textNormalCustom(
                          grey3,
                          14,
                          FontWeight.w400,
                        ),
                      ),
                      spaceH3,
                      Text(
                        (pawnshopPackage.interest != null)
                            ? '${pawnshopPackage.interest}% APR'
                            : '${pawnshopPackage.interestMin} - '
                                '${pawnshopPackage.interestMax}% APR',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Loan type',
                        style: textNormalCustom(
                          grey3,
                          14,
                          FontWeight.w400,
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
                grey3,
                14,
                FontWeight.w400,
              ),
            ),
            spaceH5,
            SizedBox(
              height: 30.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                            return Row(
                              children: [
                                SizedBox(
                                  width: 16.w,
                                  height: 16.h,
                                  child: Image.network(
                                    ImageAssets.getUrlToken(
                                      pawnshopPackage
                                              .acceptableAssetsAsCollateral?[
                                                  index]
                                              .symbol ??
                                          '',
                                    ),
                                  ),
                                ),
                                spaceW8,
                              ],
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
                            return Row(
                              children: [
                                SizedBox(
                                  width: 16.w,
                                  height: 16.h,
                                  child: Image.network(
                                    ImageAssets.getUrlToken(
                                      pawnshopPackage
                                              .acceptableAssetsAsCollateral?[
                                                  index]
                                              .symbol ??
                                          '',
                                    ),
                                  ),
                                ),
                                spaceW8,
                              ],
                            );
                          },
                        ),
                      if ((pawnshopPackage
                                  .acceptableAssetsAsCollateral?.length ??
                              0) >
                          5)
                        Text(
                          '& ${pawnshopPackage.acceptableAssetsAsCollateral!.length - 5} more',
                          style: textNormalCustom(
                            Colors.white,
                            14,
                            FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                  Image.asset(
                    ImageAssets.ic_bsc_svg,
                    height: 20.h,
                    width: 20.w,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget typeLoan() {
    switch (pawnshopPackage.type) {
      case 0:
        return Text(
          'Auto',
          style: textNormalCustom(
            blueMarketColor,
            20,
            FontWeight.w600,
          ),
        );
      case 1:
        return Text(
          'Semi-auto',
          style: textNormalCustom(
            orangeColor,
            20,
            FontWeight.w600,
          ),
        );
      case 2:
        return Text(
          'Negotiation',
          style: textNormalCustom(
            redMarketColor,
            20,
            FontWeight.w600,
          ),
        );
      default:
        return Text(
          'P2P',
          style: textNormalCustom(
            deliveredColor,
            20,
            FontWeight.w600,
          ),
        );
    }
  }
}
