import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListItemHorizontal extends StatelessWidget {
  const ListItemHorizontal({
    Key? key,
    required this.title,
    this.isHaveArrow = true,
    this.callBackArrow,
    required this.listItemWidget,
  }) : super(key: key);
  final String title;
  final bool? isHaveArrow;
  final Function()? callBackArrow;
  final Widget listItemWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: (isHaveArrow ?? true)
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start, //default mainAxis
            children: [
              Text(
                title,
                style: textNormalCustom(
                  AppTheme.getInstance().whiteColor(),
                  20,
                  FontWeight.w700,
                ),
              ),
              if (isHaveArrow ?? true)
                Padding(
                  padding: EdgeInsets.only(
                    right: 16.w,
                  ),
                  child: Image(
                    height: 32.h,
                    width: 32.w,
                    image: const AssetImage(
                      ImageAssets.img_push,
                    ),
                  ),
                )
              else
                Container(),
            ],
          ),
          spaceH20,
          listItemWidget,
        ],
      ),
    );
  }
}
