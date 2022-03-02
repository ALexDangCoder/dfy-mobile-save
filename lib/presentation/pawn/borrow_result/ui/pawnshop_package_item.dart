import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/domain/model/pawn/pawnshop_package.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
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

                ),
              ),
              Expanded(
                child: Column(

                ),
              ),
            ],
          ),
          spaceH4,
          Text(''),
          spaceH5,
          Row(),
        ],
      ),
    );
  }
}
