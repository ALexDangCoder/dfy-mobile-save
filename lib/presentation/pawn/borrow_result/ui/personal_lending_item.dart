import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/domain/model/pawn/personal_lending.dart';
import 'package:Dfy/presentation/pawn/send_loan_request/ui/send_loan_requet.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:Dfy/widgets/sized_image/sized_png_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalLendingItem extends StatelessWidget {
  const PersonalLendingItem(
      {Key? key, required this.personalLending, required this.listToken})
      : super(key: key);

  final PersonalLending personalLending;
  final List<String?> listToken;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 306.w,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(
        left: 16.w,
        top: 13.h,
        right: 16.w,
        bottom: 20.h,
      ),
      decoration: BoxDecoration(
        color: borderItemColors,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        border: Border.all(color: dialogColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
            children: [
              Image.asset(ImageAssets.img_star),
              spaceW6,
              Text(
                personalLending.reputation.toString(),
                style: textNormalCustom(
                  Colors.white,
                  14,
                  FontWeight.w400,
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
                  FontWeight.w400,
                ),
              ),
            ],
          ),
          spaceH8,
          Text(
            '${personalLending.minInterestRate} - '
            '${personalLending.maxInterestRate}% Interest rate',
            style: textNormalCustom(
              greenMarketColor,
              14,
              FontWeight.w400,
            ),
          ),
          spaceH6,
          Text(
            'Collateral accepted',
            style: textNormalCustom(
              grey3,
              14,
              FontWeight.w400,
            ),
          ),
          spaceH8,
          SizedBox(
            height: 30.h,
            child: Row(
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
                      return Row(
                        children: [
                          SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: Image.network(
                              ImageAssets.getUrlToken(
                                personalLending
                                        .p2PLenderPackages?[0]
                                        .acceptableAssetsAsCollateral?[index]
                                        .symbol ??
                                    '',
                              ),
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: AppTheme.getInstance().bgBtsColor(),
                                width: 16.w,
                                height: 16.w,
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
                                personalLending
                                        .p2PLenderPackages?[0]
                                        .acceptableAssetsAsCollateral?[index]
                                        .symbol ??
                                    '',
                              ),
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                color: AppTheme.getInstance().bgBtsColor(),
                                width: 16.w,
                                height: 16.h,
                              ),
                            ),
                          ),
                          spaceW8,
                        ],
                      );
                    },
                  ),
                spaceH20,
                if ((personalLending.p2PLenderPackages?[0]
                            .acceptableAssetsAsCollateral?.length ??
                        0) >
                    5)
                  InkWell(
                    onTap: () {
                      showInfo(context, listToken);
                    },
                    child: Text(
                      '& ${personalLending.p2PLenderPackages![0].acceptableAssetsAsCollateral!.length - 5} more',
                      style: textNormalCustom(
                        Colors.white,
                        14,
                        FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          spaceH20,
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SendLoanRequest(
                    packageId:
                        personalLending.p2PLenderPackages?[0].id.toString() ??
                            '',
                    pawnshopType:
                        personalLending.p2PLenderPackages?[0].type.toString() ??
                            '',
                    collateralAccepted: personalLending.p2PLenderPackages?[0]
                            .acceptableAssetsAsCollateral ??
                        [], type: personalLending.p2PLenderPackages?[0].type ?? 0,
                  ),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.only(left: 76.w),
              child: ButtonRadial(
                radius: 12,
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
          ),
        ],
      ),
    );
  }
}

void showInfo(BuildContext context, List<String?> listInfo) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              20.0.r,
            ),
          ),
        ),
        backgroundColor: AppTheme.getInstance().selectDialogColor(),
        content: SizedBox(
          width: 150.w,
          child: GridView.builder(
            padding: EdgeInsets.only(top: 10.h),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: listInfo.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: Image.network(
                      ImageAssets.getSymbolAsset(listInfo[index] ?? ''),
                    ),
                  ),
                  spaceW5,
                  Text(
                    listInfo[index] ?? '',
                    style: textNormalCustom(
                      Colors.white,
                      16,
                      FontWeight.w400,
                    ),
                  ),
                ],
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 55 / 15,
            ),
          ),
        ),
      );
    },
  );
}
