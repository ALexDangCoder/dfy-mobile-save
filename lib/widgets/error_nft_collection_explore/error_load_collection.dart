import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorLoadCollection extends StatelessWidget {
  const ErrorLoadCollection({Key? key, required this.callback}) : super(key: key);
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 235.w,
      height: 147.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
        color: AppTheme.getInstance().bgErrorLoad(),
      ),
      padding: EdgeInsets.only(top: 18.h),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 44.h,
              width: 44.w,
              child: Image.asset(ImageAssets.err_load_collection),
            ),
            spaceH10,
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
            SizedBox(
              height: 11.h,
            ),
            InkWell(
              onTap: callback,
              child: SizedBox(
                height: 36.h,
                width: 36.w,
                child: Image.asset(ImageAssets.reload_collection),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
