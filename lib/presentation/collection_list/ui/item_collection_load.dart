import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemCollectionLoad extends StatelessWidget {
  const ItemCollectionLoad({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 164.w,
          height: 181.h,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppTheme.getInstance().borderItemColor(),
            borderRadius: BorderRadius.all(
              Radius.circular(20.r),
            ),
            border: Border.all(
              color: AppTheme.getInstance().selectDialogColor(),
              width: 1.w,
            ),
          ),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: 164.w,
                height: 58.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().selectDialogColor(),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                // child: ,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  top: 25.h,
                ),
                width: 111.w,
                height: 14.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().selectDialogColor(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 6.h,
                ),
                width: 74.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().selectDialogColor(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 27.h,
                ),
                width: 138.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: AppTheme.getInstance().selectDialogColor(),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.r),
                  ),
                ),
              ),
              spaceH20,
            ],
          ),
        ),
        Positioned(
          top: 38.h,
          child: Container(
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.getInstance().borderItemColor(),
                width: 3.w,
              ),
            ),
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 37.w,
              height: 37.h,
              decoration: BoxDecoration(
                color: AppTheme.getInstance().selectDialogColor(),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
