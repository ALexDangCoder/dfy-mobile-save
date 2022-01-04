import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonCategory extends StatelessWidget {
  const SkeletonCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 130.h,
          width: 146.w,
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 77.w,
                      height: 62.w,
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().skeletonLight(),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                        ),
                      ),
                    ),
                    Container(
                      width: 8.w,
                      height: 62.h,
                      color: AppTheme.getInstance().skeleton(),
                    ),
                    Container(
                      width: 61.w,
                      height: 62.h,
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().skeletonLight(),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: 146.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().skeleton(),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 56.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().skeletonLight(),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.r),
                        ),
                      ),
                    ),
                    Container(
                      width: 7.w,
                      height: 60.h,
                      color: AppTheme.getInstance().skeleton(),
                    ),
                    Container(
                      width: 83.w,
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: AppTheme.getInstance().skeletonLight(),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(20.r),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(width: 20.w,),
      ],
    );
  }
}
