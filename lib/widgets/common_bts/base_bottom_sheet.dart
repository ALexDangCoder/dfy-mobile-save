import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// use for common bottom sheet
/// trailing icon default is false if you want use trailing icon close right trailing icon = true
/// child is a Column
/// padding bottom is 38, use common for bts have button
class BaseBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final bool trailingIcon;

  const BaseBottomSheet({
    Key? key,
    required this.title,
    required this.child,
    this.trailingIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 764.h,
      width: 375.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 64.h,
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              top: 16.h,
              bottom: 20.h,
            ),
            child: SizedBox(
              height: 28.h,
              width: 343.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 5.h,
                          left: 11.w,
                          right: 11.w,
                        ),
                        child: Image.asset(ImageAssets.ic_back),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        title,
                        style: titleText(
                          color: AppTheme.getInstance().textThemeColor(),
                        ),
                      ),
                    ),
                  ),
                  if (trailingIcon)
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 5.h,
                            left: 11.w,
                            right: 11.w,
                          ),
                          child: Image.asset(ImageAssets.ic_close),
                        ),
                      ),
                    )
                  else
                    Container(
                      margin: EdgeInsets.only(
                        right: 11.w,
                      ),
                    )
                ],
              ),
            ),
          ),
          Divider(
            color: AppTheme.getInstance().divideColor(),
          ),
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 24.h,
                bottom: 38.h,
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
