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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: AppTheme.getInstance().bgBtsColor(),
                  ),
                ),
              ),
              spaceW8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 180.w,
                    child: Text(
                      namePawnShop,
                      maxLines: 1,
                      style: textNormalCustom(
                        null,
                        16,
                        FontWeight.w600,
                      ).copyWith(
                        overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ),
                  spaceH4,
                  Row(
                    children: [
                      Image.asset(ImageAssets.img_star),
                      spaceW4,
                      Text(
                        starNumber,
                        style: textNormalCustom(
                          null,
                          14,
                          null,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: function(),
            child: Image.asset(
              ImageAssets.ic_line_right,
              width: 24.w,
              height: 24.h,
              color: AppTheme.getInstance().whiteWithOpacityFireZero(),
            ),
          ),
        ],
      ),
    );
  }
}
