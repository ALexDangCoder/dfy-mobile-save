import 'dart:ui';

import 'package:Dfy/config/resources/dimen.dart';
import 'package:Dfy/config/resources/styles.dart';
import 'package:Dfy/config/themes/app_theme.dart';
import 'package:Dfy/generated/l10n.dart';
import 'package:Dfy/utils/constants/image_asset.dart';
import 'package:Dfy/widgets/button/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BaseSuccess extends StatelessWidget {
  const BaseSuccess({
    Key? key,
    required this.title,
    required this.content,
    required this.callback,
  }) : super(key: key);
  final String title;
  final String content;
  final Function() callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 812.h,
          width: 375.w,
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          decoration: BoxDecoration(
            color: AppTheme.getInstance().bgBtsColor(),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18.h,
              ),
              Center(
                child: Text(
                  title,
                  style: textNormalCustom(
                    Colors.white,
                    20,
                    FontWeight.bold,
                  ),
                ),
              ),
              spaceH20,
              line,
              spaceH24,
              SizedBox(
                height: 56.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 228.h,
                          width: 305.w,
                          child: Image.asset(ImageAssets.frameGreen),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        Text(
                          content,
                          style: textNormalCustom(
                            Colors.white,
                            32,
                            FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 213.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: callback,
                  child: ButtonGold(
                    title: S.current.complete,
                    isEnable: true,
                  ),
                ),
              ),
              spaceH38,
            ],
          ),
        ),
      ),
    );
  }
}
