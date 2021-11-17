import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FromText4 extends StatelessWidget {
  final String urlPrefixIcon;
  final String title;
  final String urlSuffixIcon;
  final String titleCopy;

  const FromText4({
    Key? key,
    required this.urlPrefixIcon,
    required this.title,
    required this.urlSuffixIcon,
    required this.titleCopy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 343.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 15.5.w, vertical: 23.h),
      decoration: BoxDecoration(
        color: AppTheme.getInstance().itemBtsColors(),
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                urlPrefixIcon,
                height: 20.h,
                width: 20.14.w,
              ),
              SizedBox(
                width: 17.5.w,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  title,
                  style: textNormal(
                    Colors.grey,
                    16,
                  ),
                ),
              ),
            ],
          ),
          Image.asset(
            urlSuffixIcon,
            height: 20.67.h,
            width: 20.14.w,
          ),
        ],
      ),
    );
  }
}
