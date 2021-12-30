import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonCollection extends StatelessWidget {
  const SkeletonCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 147.h,
      width: 235.w,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: 235.w,
                height: 81.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().skeletonLight(),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
              ),
              Container(
                width: 235.w,
                height: 66.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.r),
                    bottomRight: Radius.circular(20.r),
                  ),
                  color: AppTheme.getInstance().skeleton(),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                    top: 35.h,
                    bottom: 15.h,
                    left: 42.5.w,
                    right: 42.5.w,
                  ),
                  width: 150.w,
                  height: 16.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppTheme.getInstance().skeletonLight(),
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 47.h,
            left: 88.w,
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.getInstance().skeleton(),
                // color: Colors.red,
              ),
              padding: EdgeInsets.all(4.r),
              child: Container(
                width: 52.h,
                height: 52.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.getInstance().skeletonLight(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
