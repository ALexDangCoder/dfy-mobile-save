import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/widgets/toast/toast_copy.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FromText2 extends StatelessWidget {
  final String urlPrefixIcon;
  final String title;
  final String urlSuffixIcon;

  const FromText2({
    Key? key,
    required this.urlPrefixIcon,
    required this.title,
    required this.urlSuffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 15.5.w),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().backgroundBTSColor(),
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                height: 24.h,
                width: 24.w,
                child: Image.asset(
                  urlPrefixIcon,
                ),
              ),
              SizedBox(
                width: 20.5.w,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  title,
                  style: textNormal(
                      AppTheme.getInstance().whiteWithOpacityFireZero(), 16.sp),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              FlutterClipboard.copy(title);
              toast_copy();
            },
            child: SizedBox(
              height: 20.h,
              width: 20.w,
              child: urlSuffixIcon.isNotEmpty
                  ? Image.asset(
                      urlSuffixIcon,
                      height: 20.h,
                      width: 20.w,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
