import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button_radial_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: 48.h,
          ),
          Container(
            height: 764.h,
            width: 375.w,
            decoration: BoxDecoration(
              color: const Color(0xff3e3d5c),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 64.h,
                ),
                Divider(
                  height: 1.h,
                  color: AppTheme.getInstance().divideColor(),
                ),
                SizedBox(
                  height: 33.h,
                ),
                Image(
                  image: const AssetImage(ImageAssets.image_coming),
                  height: 342.h,
                  width: 251.w,
                ),
                SizedBox(
                  height: 39.h,
                ),
                Text(
                  S.current.feature_coming_soon,
                  style: textNormalCustom(
                    Colors.white,
                    32,
                    FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 120.h,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ButtonRadial(
                      child: Center(
                        child: Text(
                          S.current.back,
                          style: textNormalCustom(
                            Colors.white,
                            20,
                            FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
