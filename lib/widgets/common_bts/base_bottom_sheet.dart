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
  final bool isHaveLeftIcon;

  const BaseBottomSheet({
    Key? key,
    required this.title,
    required this.child,
    this.text,
    this.callback,
    this.isImage,
    this.isHaveLeftIcon = true,
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
          SizedBox(
            height: 64.h,
            child: SizedBox(
              height: 28.h,
              width: 343.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (isHaveLeftIcon)
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
                    )
                  else
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          // Navigator.pop(context);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 11.w,
                            right: 11.w,
                          ),
                          child: SizedBox(
                            height: 28.h,
                            width: 28.w,
                          ),
                        ),
                      ),
                    ),
                  Flexible(
                    flex: 6,
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
            child: child,
          ),
        ],
      ),
    );
  }
}
