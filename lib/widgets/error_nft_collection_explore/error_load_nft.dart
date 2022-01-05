import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorLoadNft extends StatelessWidget {
  const ErrorLoadNft({Key? key, required this.callback,}) : super(key: key);
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156.w,
      height: 231.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        color: AppTheme.getInstance().bgErrorLoad(),
      ),
      padding: EdgeInsets.only(top: 28.h),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 54.h,
              width: 54.w,
              child: Image.asset(ImageAssets.err_load_nft),
            ),
            spaceH16,
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
            spaceH30,
            InkWell(
              onTap: callback,
              child: SizedBox(
                height: 54.h,
                width: 54.w,
                child: Image.asset(ImageAssets.reload_nft),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
