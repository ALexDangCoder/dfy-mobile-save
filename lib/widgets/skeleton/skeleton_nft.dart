import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonNft extends StatelessWidget {
  const SkeletonNft({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.w,
      height: 231.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: AppTheme.getInstance().skeleton(),
      ),
      child: Stack(
        children: [
          //anh nft
          Positioned(
            top: 8.h,
            left: 8.w,
            right: 8.w,
            child: Container(
              width: 140.w,
              height: 129.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: AppTheme.getInstance().skeletonLight(),
              ),
            ),
          ),
          Positioned(
            top: 149.h,
            left: 8.w,
            child: Container(
              width: 121.w,
              height: 16.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppTheme.getInstance().skeletonLight(),
              ),
            ),
          ),
          Positioned(
            top: 171.h,
            left: 8.w,
            child: Container(
              width: 68.w,
              height: 12.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: AppTheme.getInstance().skeletonLight(),
              ),
            ),
          ),
          Positioned(
            top: 199.h,
            left: 8.w,
            child: Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().skeletonLight(),
                borderRadius: BorderRadius.circular(50.r),
                // shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: 199.h,
            left: 32.w,
            child: Container(
              width: 116.w,
              height: 16.h,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().skeletonLight(),
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
