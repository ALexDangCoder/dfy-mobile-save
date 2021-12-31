import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorLoadExplore extends StatelessWidget {
  const ErrorLoadExplore({Key? key, required this.callback}) : super(key: key);
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 146.w,
          height: 130.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20.r)),
            color: AppTheme.getInstance().bgErrorLoad(),
          ),
          padding: EdgeInsets.only(top: 11.h),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                  width: 40.w,
                  child: Image.asset(ImageAssets.err_load_category),
                ),
                spaceH4,
                Flexible(
                  child: Text(
                    S.current.could_not_load_data,
                    style: textNormalCustom(
                      const Color(0xffE6E6E6),
                      13.sp,
                      FontWeight.w400,
                    ),
                  ),
                ),
                spaceH12,
                InkWell(
                  onTap: callback,
                  child: SizedBox(
                    height: 36.h,
                    width: 36.w,
                    child: Image.asset(ImageAssets.reload_category),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        )
      ],
    );
  }
}
