import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FromText extends StatelessWidget {
  final String urlPrefixIcon;
  final String title;
  final String urlSuffixIcon;

  const FromText({
    Key? key,
    required this.urlPrefixIcon,
    required this.title,
    required this.urlSuffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 26.w),
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
                    16.sp,
                  ),
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              FlutterClipboard.copy(title);
              Fluttertoast.showToast(
                msg: S.current.copy,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
              );
            },
            child: Container(
              child: urlSuffixIcon.isNotEmpty
                  ? Image.asset(
                      urlSuffixIcon,
                      height: 20.67.h,
                      width: 20.14.w,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
