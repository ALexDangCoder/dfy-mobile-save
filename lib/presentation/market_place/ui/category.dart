import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Category extends StatelessWidget {
  const Category({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 130.h,
          width: 146.w,
          child: Stack(
            children: [
              Container(
                height: 130.h,
                width: 146.w,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage(ImageAssets.img_categories),
                    fit: BoxFit.fill,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 12.w,
                  top: 98.h,
                ),
                child: Text(
                  title,
                  style: textNormalCustom(
                    Colors.white,
                    16.sp,
                    FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 20.w,),
      ],
    );
  }
}
