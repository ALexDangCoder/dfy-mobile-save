import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemPawnShopStar extends StatelessWidget {
  final String avatarPawnShopUrl;
  final String namePawnShop;
  final String starNumber;
  final Function function;

  const ItemPawnShopStar({
    Key? key,
    required this.avatarPawnShopUrl,
    required this.namePawnShop,
    required this.starNumber,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 12.w,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: BorderRadius.all(
          Radius.circular(
            20.r,
          ),
        ),
      ),
      child: Row(
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
          Column(
            children: [
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
          Row(
            children: [
              Image.asset(ImageAssets.img_star)
            ],
          ),
        ],
      ),
    );
  }
}
