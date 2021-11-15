import 'package:Dfy/config/resources/styles.dart';
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
      width: 323.w,
      height: 64.h,
      margin: EdgeInsets.symmetric(horizontal: 26.w),
      padding: EdgeInsets.symmetric(horizontal: 15.5.w, vertical: 23.h),
      decoration: const BoxDecoration(
        color: Color(0xff32324c),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                urlPrefixIcon,
              ),
              SizedBox(
                width: 23.5.w,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  title,
                  style: textNormal(Colors.grey, 16.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              FlutterClipboard.copy(title);

              toast_copy();
            },
            child: Container(
              child: urlSuffixIcon.isNotEmpty
                  ? Image.asset(
                      urlSuffixIcon,
                      height: 17.67.h,
                      width: 19.14.w,
                    )
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
