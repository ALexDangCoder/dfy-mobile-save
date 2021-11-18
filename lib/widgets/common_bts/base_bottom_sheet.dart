import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// use for common bottom sheet
/// child is a Column
/// padding bottom is 38, use common for bts have button
/// if has right icon or text, assign value for arg text
/// if this is arg text is image isImage = true, opposite with text
class BaseBottomSheet extends StatelessWidget {
  final String title;
  final Widget child;
  final String? text;
  final bool? isImage;
  final Function()? callback;

  const BaseBottomSheet({
    Key? key,
    required this.title,
    required this.child,
    this.text,
    this.callback,
    this.isImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 764.h,
      width: 375.w,
      decoration: BoxDecoration(
        color: AppTheme.getInstance().bgBtsColor(),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
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
                          left: 11.w,
                          right: 11.w,
                        ),
                        child: Image.asset(ImageAssets.ic_back),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Align(
                      child: Text(
                        title,
                        style: titleText(
                          color: AppTheme.getInstance().textThemeColor(),
                        ),
                      ),
                    ),
                  ),
                  if (text != null)
                    Flexible(
                      child: InkWell(
                        onTap: callback,
                        child: isImage ?? false
                            ? Image.asset(text ?? '')
                            : Text(
                                text ?? '',
                                style: textNormalCustom(
                                  AppTheme.getInstance().fillColor(),
                                  16,
                                  FontWeight.w700,
                                ),
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
              ),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
