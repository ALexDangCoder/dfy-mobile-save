import 'package:Dfy/config/resources/color.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultSubScreen extends StatelessWidget {
  final String title;
  final Widget mainWidget;

  const DefaultSubScreen(
      {Key? key, required this.title, required this.mainWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.black,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.h),
                topRight: Radius.circular(30.h),
              ),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: listBackgroundColor,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: 16.h, left: 16.h, right: 16.h, bottom: 20.h,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 28.h,
                        width: 28.h,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Image.asset(ImageAssets.backArrow),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            title,
                            style: titleText(
                              color: AppTheme.getInstance().textThemeColor(),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28.h,
                        width: 28.h,
                      )
                    ],
                  ),
                ),
                Divider(
                  color: AppTheme.getInstance().divideColor(),
                ),
                Expanded(child: mainWidget),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
